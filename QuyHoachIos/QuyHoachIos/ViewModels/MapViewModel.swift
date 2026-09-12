import Foundation
import Combine
import CoreLocation
import SwiftUI

enum MapBackgroundType: String, CaseIterable, Identifiable {
    case hybrid = "Vệ tinh + Địa danh"
    case satellite = "Vệ tinh sạch"
    case standard = "Bản đồ đường bộ"
    case terrain = "Bản đồ địa hình"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .hybrid: return "globe.americas.fill"
        case .satellite: return "sparkles"
        case .standard: return "map.fill"
        case .terrain: return "mountain.2.fill"
        }
    }

    var tileUrl: String {
        switch self {
        case .hybrid: return "https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}"
        case .satellite: return "https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
        case .standard: return "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}"
        case .terrain: return "https://mt1.google.com/vt/lyrs=p&x={x}&y={y}&z={z}"
        }
    }
}

enum MeasureMode: String, CaseIterable, Identifiable {
    case none = "Không đo"
    case distance = "Đo khoảng cách"
    case area = "Đo diện tích"

    var id: String { self.rawValue }
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var selectedProvince: Province
    @Published var activeLayer: PlanningLayer?
    @Published var availableLayers: [PlanningLayer] = []
    @Published var opacityValue: Double = 0.75
    @Published var searchQuery: String = ""
    @Published var selectedRegion: Region = .all
    @Published var provinceFilterText: String = ""
    @Published var mapBackground: MapBackgroundType = .hybrid

    // Measurement Tool State
    @Published var measureMode: MeasureMode = .none
    @Published var measuredDistanceMeters: Double = 0.0
    @Published var measuredAreaSquareMeters: Double = 0.0
    @Published var measuredPointsCount: Int = 0

    // Saved Parcels (Bookmarks)
    @Published var selectedPeriod: PlanningPeriod = .qh2030
    @Published var locationPrompt: LocationPrompt? = nil
    @Published var savedParcels: [Parcel] = []
    @Published var searchHistory: [String] = [
        "Hà Nội, Hoàn Kiếm",
        "Khu Đô thị Thủ Thiêm, TP.HCM",
        "Đường Bạch Đằng, Đà Nẵng",
        "Khu công nghiệp VSIP, Bình Dương"
    ]

    // VN-2000 Polygon ranh giới thửa đất
    @Published var activeVN2000Polygon: VN2000PolygonResult? = nil

    // Sheets / Modals
    @Published var isShowingProvincePicker: Bool = false
    @Published var isShowingLegendSheet: Bool = false
    @Published var isShowingParcelDetail: Bool = false
    @Published var isShowingVN2000Sheet: Bool = false
    @Published var isShowingBookmarksSheet: Bool = false
    @Published var isShowingBaseMapPicker: Bool = false
    @Published var inspectedParcel: Parcel? = nil

    // UI state
    @Published var isFullScreenMode: Bool = false
    @Published var isLocating: Bool = false
    @Published var targetCoordinate: CLLocationCoordinate2D? = nil

    // Map Action Triggers
    @Published var zoomInTrigger: Int = 0
    @Published var zoomOutTrigger: Int = 0
    @Published var resetNorthTrigger: Int = 0

    // === State cho Drawer trượt trái & LocationInfoPopup (chuẩn Android/Web) ===
    @Published var isDrawerOpen: Bool = false
    @Published var tappedPopupParcel: Parcel? = nil  // Parcel từ tap bản đồ để hiển thị LocationInfoPopup

    // Camera tracking - tránh Camera Jump Bug khi SwiftUI re-render
    private(set) var lastFlyToCoord: CLLocationCoordinate2D? = nil
    private(set) var lastFlyToProvinceId: String = ""
    private(set) var lastFlyToLayerId: String = ""
    private(set) var lastFlyToBase: String = ""

    private let locationManager = CLLocationManager()
    let repository = ProvinceRepository.shared

    override init() {
        let defaultProvince = ProvinceRepository.shared.provinces.first!
        self.selectedProvince = defaultProvince
        self.targetCoordinate = defaultProvince.coordinate
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.refreshLayers()
        self.loadSampleBookmarks()
    }

    var filteredProvinces: [Province] {
        repository.searchProvinces(query: provinceFilterText, region: selectedRegion)
    }

    func selectProvince(_ province: Province) {
        self.selectedProvince = province
        self.targetCoordinate = province.coordinate
        self.refreshLayers()
        self.isDrawerOpen = false // Đóng drawer sau khi chọn tỉnh
    }

    func selectPeriod(_ period: PlanningPeriod) {
        self.selectedPeriod = period
        let periodLayers = repository.getLayersByPeriod(for: selectedProvince.id, period: period)
        if let firstLayer = periodLayers.first {
            self.selectLayer(firstLayer)
        }
    }

    func selectLayer(_ layer: PlanningLayer) {
        self.activeLayer = layer
        self.selectedPeriod = layer.period
    }

    func setOpacity(_ value: Double) {
        self.opacityValue = max(0.0, min(1.0, value))
    }

    func setMapBackground(_ type: MapBackgroundType) {
        self.mapBackground = type
    }

    // === Camera Jump Bug Fix ===
    /// Gọi sau khi WebView đã thực hiện camera fly. SwiftUI sẽ không trigger lại nếu giá trị không đổi.
    func markCameraAsFlown(coord: CLLocationCoordinate2D, provinceId: String, layerId: String, base: String) {
        self.lastFlyToCoord = coord
        self.lastFlyToProvinceId = provinceId
        self.lastFlyToLayerId = layerId
        self.lastFlyToBase = base
    }

    func needsCameraFly(coord: CLLocationCoordinate2D?, provinceId: String, layerId: String, base: String) -> Bool {
        guard let c = coord else { return false }
        let coordChanged = lastFlyToCoord.map {
            abs($0.latitude - c.latitude) > 0.0001 || abs($0.longitude - c.longitude) > 0.0001
        } ?? true
        return coordChanged || provinceId != lastFlyToProvinceId || layerId != lastFlyToLayerId || base != lastFlyToBase
    }

    // === Drawer Control ===
    func openDrawer() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isDrawerOpen = true
        }
    }

    func toggleDrawer() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isDrawerOpen.toggle()
        }
    }

    func closeDrawer() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isDrawerOpen = false
        }
    }

    private func refreshLayers() {
        let layers = repository.getLayers(for: selectedProvince.id)
        self.availableLayers = layers
        let periodLayers = layers.filter { $0.period == selectedPeriod }
        self.activeLayer = periodLayers.first ?? layers.first
    }

    // MARK: - Measurement Actions
    func setMeasureMode(_ mode: MeasureMode) {
        self.measureMode = mode
        if mode == .none {
            self.measuredDistanceMeters = 0.0
            self.measuredAreaSquareMeters = 0.0
            self.measuredPointsCount = 0
        }
    }

    func clearMeasurement() {
        self.measuredDistanceMeters = 0.0
        self.measuredAreaSquareMeters = 0.0
        self.measuredPointsCount = 0
    }

    // MARK: - VN-2000 Polygon Overlay
    func applyVN2000Polygon(_ polygon: VN2000PolygonResult) {
        self.activeVN2000Polygon = polygon
        self.targetCoordinate = polygon.centerCoordinate
        self.isShowingVN2000Sheet = false
    }

    func clearVN2000Polygon() {
        self.activeVN2000Polygon = nil
    }

    // MARK: - Bookmarks Management
    func toggleBookmark(_ parcel: Parcel) {
        if let idx = savedParcels.firstIndex(where: { $0.id == parcel.id }) {
            savedParcels.remove(at: idx)
            if inspectedParcel?.id == parcel.id {
                inspectedParcel?.isBookmarked = false
            }
        } else {
            var newParcel = parcel
            newParcel.isBookmarked = true
            newParcel.savedDate = Date()
            savedParcels.append(newParcel)
            if inspectedParcel?.id == parcel.id {
                inspectedParcel?.isBookmarked = true
            }
        }
    }

    func deleteSavedParcel(_ parcel: Parcel) {
        savedParcels.removeAll(where: { $0.id == parcel.id })
    }

    private func loadSampleBookmarks() {
        let hn = repository.provinces[0]
        var sample1 = repository.lookupParcel(query: "Hà Nội", province: hn)
        sample1.plotNumber = "88"
        sample1.sheetNumber = "12"
        sample1.address = "Phường Dịch Vọng Hậu, Quận Cầu Giấy, Hà Nội"
        sample1.customNote = "Thửa đất mặt tiền đường 12m, gần công viên Cầu Giấy"
        sample1.isBookmarked = true
        sample1.savedDate = Date().addingTimeInterval(-86400 * 2)

        let hcm = repository.provinces.first(where: { $0.id == "hcm" }) ?? hn
        var sample2 = repository.lookupParcel(query: "TP.HCM", province: hcm)
        sample2.plotNumber = "105"
        sample2.sheetNumber = "34"
        sample2.address = "Phường An Khánh, TP. Thủ Đức, TP. Hồ Chí Minh"
        sample2.customNote = "Khu đô thị mới Thủ Thiêm, quy hoạch đất ở cao tầng"
        sample2.isBookmarked = true
        sample2.savedDate = Date().addingTimeInterval(-86400 * 5)

        self.savedParcels = [sample1, sample2]
    }

    // MARK: - Location GPS
    func requestUserLocation() {
        isLocating = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.targetCoordinate = location.coordinate
            self.isLocating = false
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.isLocating = false
        }
    }

    // MARK: - Search & Navigation
    func confirmLocationPrompt() {
        guard let prompt = locationPrompt else { return }
        self.navigateToLocation(
            latitude: prompt.latitude,
            longitude: prompt.longitude,
            zoom: prompt.zoom.map { Float($0) },
            layerIds: prompt.layerIds
        )
        self.locationPrompt = nil
    }

    func dismissLocationPrompt() {
        self.locationPrompt = nil
    }

    func navigateToLocation(
        latitude: Double,
        longitude: Double,
        zoom: Float? = nil,
        layerIds: [String] = []
    ) {
        let (finalLat, finalLng): (Double, Double)
        if latitude >= 8.0 && latitude <= 24.0 && longitude >= 102.0 && longitude <= 112.0 {
            finalLat = latitude; finalLng = longitude
        } else if longitude >= 8.0 && longitude <= 24.0 && latitude >= 102.0 && latitude <= 112.0 {
            finalLat = longitude; finalLng = latitude
        } else {
            finalLat = latitude; finalLng = longitude
        }

        let closest = repository.findClosestProvince(lat: finalLat, lng: finalLng)
        self.selectedProvince = closest
        self.refreshLayers()

        if !layerIds.isEmpty {
            let matched = self.availableLayers.first { layer in
                layerIds.contains { id in
                    let clean = id.replacingOccurrences(of: "_", with: "-").lowercased()
                    return layer.id.lowercased().contains(clean) || layer.label.lowercased().contains(clean)
                }
            }
            if let m = matched {
                self.selectLayer(m)
            }
        }

        self.targetCoordinate = CLLocationCoordinate2D(latitude: finalLat, longitude: finalLng)
        self.inspectAtCoordinate(lat: finalLat, lng: finalLng)
    }

    func performSearch() {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return }

        // Lưu lịch sử tìm kiếm
        if !searchHistory.contains(query) {
            searchHistory.insert(query, at: 0)
            if searchHistory.count > 10 {
                searchHistory.removeLast()
            }
        }

        // 1. Nếu dán cả đường link quy hoạch
        if query.contains("lat=") || query.contains("http") || query.contains("quyhoach") {
            if let url = URL(string: query), let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                let items = components.queryItems ?? []
                let latStr = items.first(where: { $0.name == "lat" })?.value
                let lngStr = items.first(where: { $0.name == "long" || $0.name == "lng" })?.value
                let zoomStr = items.first(where: { $0.name == "zoom" })?.value
                let ids = items.filter({ $0.name == "id" }).compactMap({ $0.value })
                if let lat = Double(latStr ?? ""), let lng = Double(lngStr ?? "") {
                    let zoom = Double(zoomStr ?? "") ?? 16.0
                    self.locationPrompt = LocationPrompt(latitude: lat, longitude: lng, zoom: zoom, layerIds: ids, source: "Liên kết quy hoạch")
                    return
                }
            }
        }

        // 2. Nhập tọa độ trực tiếp (vd: "21.04397, 105.82748" hoặc "21.04397 105.82748")
        let coordParts = query.replacingOccurrences(of: "lat=", with: "")
            .replacingOccurrences(of: "long=", with: "")
            .replacingOccurrences(of: "lng=", with: "")
            .components(separatedBy: CharacterSet(charactersIn: ", ;"))
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        if coordParts.count >= 2, let num1 = Double(coordParts[0]), let num2 = Double(coordParts[1]) {
            let (lat, lng): (Double, Double)
            if num1 >= 8.0 && num1 <= 24.0 && num2 >= 102.0 && num2 <= 112.0 {
                lat = num1; lng = num2
            } else if num2 >= 8.0 && num2 <= 24.0 && num1 >= 102.0 && num1 <= 112.0 {
                lat = num2; lng = num1
            } else {
                lat = num1; lng = num2
            }

            if lat >= 8.0 && lat <= 24.0 && lng >= 102.0 && lng <= 112.0 {
                let zoom = coordParts.count >= 3 ? (Double(coordParts[2]) ?? 16.0) : 16.0
                self.locationPrompt = LocationPrompt(latitude: lat, longitude: lng, zoom: zoom, layerIds: [], source: "Tọa độ GPS")
                return
            }
        }

        // 3. Tìm kiếm theo Tỉnh / Thành
        if let matched = repository.searchProvinces(query: query).first {
            self.selectProvince(matched)
            return
        }

        // 4. Tìm kiếm Thửa đất
        var parcel = repository.lookupParcel(query: query, province: selectedProvince)
        if query.contains("thửa") || query.contains("tờ") {
            parcel.address = "\(query), \(selectedProvince.name)"
        }
        self.inspectedParcel = parcel
        self.targetCoordinate = parcel.coordinate
        self.isShowingParcelDetail = true
    }

    func inspectAtCoordinate(lat: Double, lng: Double, landTypeName: String? = nil, grpName: String? = nil, landCode: String? = nil) {
        var landType = repository.landTypes[0] // ODT default
        if let code = landCode, let found = repository.landTypes.first(where: { $0.code.uppercased() == code.uppercased() }) {
            landType = found
        } else if let name = landTypeName, !name.isEmpty {
            landType = LandType(
                code: landCode ?? "QH",
                name: name,
                hexColor: "#10B981",
                description: grpName ?? "Quy hoạch sử dụng đất",
                category: .residential,
                canConvertToResidential: true,
                legalReference: "Theo bản đồ quy hoạch được phê duyệt"
            )
        }

        let vnCoord = VN2000Converter.shared.wgs84ToVN2000(
            coordinate: .init(latitude: lat, longitude: lng),
            centralMeridian: selectedProvince.centralMeridian
        )

        let isBookmarked = savedParcels.contains(where: {
            abs($0.latitude - lat) < 0.0001 && abs($0.longitude - lng) < 0.0001
        })

        self.inspectedParcel = Parcel(
            id: UUID().uuidString,
            provinceId: selectedProvince.id,
            provinceName: selectedProvince.name,
            districtName: "Quận/Huyện",
            wardName: "Phường/Xã",
            plotNumber: "\(Int.random(in: 1...120))",
            sheetNumber: "\(Int.random(in: 1...40))",
            area: Double(Int.random(in: 85...280)) + 0.5,
            currentLandType: repository.landTypes[6], // CLN
            planningLandType: landType,
            address: "\(selectedProvince.name), Việt Nam",
            latitude: lat,
            longitude: lng,
            vn2000X: vnCoord.x,
            vn2000Y: vnCoord.y,
            note: landTypeName ?? (activeLayer?.label ?? "Quy hoạch đất ở đô thị"),
            legalNote: "Đủ điều kiện cấp chứng nhận quyền sử dụng đất & giấy phép xây dựng",
            planningWarning: (landType.category == .publicUtility || landType.code == "DGT") ? "Cảnh báo: Thửa đất có quy hoạch lộ giới giao thông hoặc công trình công cộng" : nil,
            isBookmarked: isBookmarked,
            savedDate: isBookmarked ? Date() : nil,
            customNote: "",
            estimatedPriceMillionPerM2: Double(Int.random(in: 30...95)),
            buildingDensity: "80% - 90%",
            maxFloors: "5 tầng + lửng + tum"
        )

        // === Chuẩn Android/Web UX: Tap → LocationInfoPopup (card nhỏ) → [Chi tiết] → Sheet đầy đủ
        // KHÔNG mở detail sheet ngay mà hiện popup nhỏ trước
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            self.tappedPopupParcel = self.inspectedParcel
        }
        self.inspectedParcel = nil  // Clear để tránh trigger onChange trong HomeScreen
    }


    // MARK: - Deep Link Navigation
    func handleDeepLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        let queryItems = components.queryItems ?? []

        var lat: Double? = nil
        var lng: Double? = nil
        var zoom: Double? = nil
        var layerIds: [String] = []

        for item in queryItems {
            let name = item.name.lowercased()
            if name == "lat" {
                lat = Double(item.value ?? "")
            } else if name == "long" || name == "lng" {
                lng = Double(item.value ?? "")
            } else if name == "zoom" || name == "z" {
                zoom = Double(item.value ?? "")
            } else if name == "id" || name == "layer" {
                if let val = item.value {
                    layerIds.append(val)
                }
            }
        }

        if let lat = lat, let lng = lng {
            navigateToLocation(lat: lat, lng: lng, zoom: zoom, layerIds: layerIds)
        }
    }

    func navigateToLocation(lat: Double, lng: Double, zoom: Double? = nil, layerIds: [String] = []) {
        let closestProvince = repository.findClosestProvince(lat: lat, lng: lng)
        self.selectProvince(closestProvince)

        if !layerIds.isEmpty {
            let matchedLayer = self.availableLayers.first { layer in
                layerIds.contains { id in
                    let cleanId = id.replacingOccurrences(of: "_", with: "-").lowercased()
                    return layer.id.lowercased().contains(cleanId) || layer.label.lowercased().contains(cleanId)
                }
            }
            if let matched = matchedLayer {
                self.activeLayer = matched
            }
        }

        self.targetCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.inspectAtCoordinate(lat: lat, lng: lng)
    }
}
