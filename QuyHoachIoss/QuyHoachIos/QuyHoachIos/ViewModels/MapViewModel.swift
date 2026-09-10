import Foundation
import Combine
import CoreLocation

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
    }

    func selectLayer(_ layer: PlanningLayer) {
        self.activeLayer = layer
    }

    func setOpacity(_ value: Double) {
        self.opacityValue = max(0.0, min(1.0, value))
    }

    func setMapBackground(_ type: MapBackgroundType) {
        self.mapBackground = type
    }

    private func refreshLayers() {
        let layers = repository.getLayers(for: selectedProvince.id)
        self.availableLayers = layers
        self.activeLayer = layers.first
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

    // MARK: - Search
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

        // 1. Kiểm tra tìm kiếm tọa độ GPS (WGS84: 21.0285, 105.8542)
        let parts = query.components(separatedBy: CharacterSet(charactersIn: ", ;")).filter { !$0.isEmpty }
        if parts.count == 2, let lat = Double(parts[0]), let lng = Double(parts[1]),
           lat >= 8.0 && lat <= 24.0, lng >= 102.0 && lng <= 112.0 {
            self.targetCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.inspectAtCoordinate(lat: lat, lng: lng)
            return
        }

        // 2. Kiểm tra tìm kiếm theo Tỉnh / Thành
        if let matched = repository.searchProvinces(query: query).first {
            self.selectProvince(matched)
            return
        }

        // 3. Tìm kiếm Thửa đất
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
        self.isShowingParcelDetail = true
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
