import Foundation

/// Sinh danh sách PlanningLayer thực tế cho từng tỉnh/thành từ GulandPlanningCatalog,
/// đối chiếu 100% logic với Android GulandPlanningLayerRepository.kt.
enum GulandPlanningLayerRepository {

    static func getLayers(for provinceId: String) -> [PlanningLayer] {
        var layers: [PlanningLayer] = []

        // 🌟 Đặc thù Hà Nội: khớp chuẩn với danh mục quyhoach_web-main & Android GulandPlanningLayerRepository.kt
        if provinceId == "hanoi" {
            return hanoiLayers
        }

        guard let info = GulandPlanningCatalog.getProvinceInfo(provinceId) else { return [] }
        let maxZoom = max(Double(info.maxNativeZoom), 22)

        // 1. Kỳ QH 2030 (Sử dụng đất)
        if let qh2030 = info.qh2030, !qh2030.isEmpty {
            layers.append(PlanningLayer(
                id: "\(info.id)-sdd-2030",
                provinceId: info.id,
                type: .sdd,
                period: .qh2030,
                label: "QH Sử dụng đất 2030",
                tileUrlTemplate: qh2030,
                isVector: false,
                colorHex: "#F97316",
                minZoom: 5,
                maxZoom: maxZoom
            ))
        }

        // 2. Kỳ Kế hoạch hàng năm (KH hàng năm / Kế hoạch 2026)
        if let khHangNam = info.khHangNam, !khHangNam.isEmpty {
            layers.append(PlanningLayer(
                id: "\(info.id)-sdd-annual",
                provinceId: info.id,
                type: .sdd,
                period: .khHangNam,
                label: "KH Sử dụng đất hàng năm",
                tileUrlTemplate: khHangNam,
                isVector: false,
                colorHex: "#10B981",
                minZoom: 5,
                maxZoom: maxZoom
            ))
        }

        // 3. Lớp Ranh thửa đất / Địa chính
        if let layerLand = info.layerLand, !layerLand.isEmpty {
            layers.append(PlanningLayer(
                id: "\(info.id)-land-parcel",
                provinceId: info.id,
                type: .chiTiet,
                period: .qhKhac,
                label: "Ranh thửa đất / Địa chính",
                tileUrlTemplate: layerLand,
                isVector: false,
                colorHex: "#06B6D4",
                minZoom: 5,
                maxZoom: maxZoom
            ))
        }

        // 4. Các lớp chi tiết mở rộng (QH Phân khu, Chi tiết 1/500, Xây dựng, Giao thông...)
        var registeredUrls = Set<String>()
        if let qh2030 = info.qh2030 { registeredUrls.insert(qh2030) }
        if let khHangNam = info.khHangNam { registeredUrls.insert(khHangNam) }
        if let layerLand = info.layerLand { registeredUrls.insert(layerLand) }

        for (idx, extra) in info.extraLayers.enumerated() {
            if registeredUrls.contains(extra.url) { continue }
            registeredUrls.insert(extra.url)
            let (type, period) = categorizeExtra(label: extra.label)
            let color = pickColor(for: extra.label, index: idx)
            layers.append(PlanningLayer(
                id: "\(info.id)-extra-\(idx)",
                provinceId: info.id,
                type: type,
                period: period,
                label: extra.label,
                tileUrlTemplate: extra.url,
                isVector: false,
                colorHex: color,
                minZoom: 5,
                maxZoom: maxZoom
            ))
        }

        return layers
    }

    static func getLayersByPeriod(for provinceId: String, period: PlanningPeriod) -> [PlanningLayer] {
        return getLayers(for: provinceId).filter { $0.period == period }
    }

    static func getLayer(provinceId: String, type: PlanningType, period: PlanningPeriod) -> PlanningLayer? {
        let layersInPeriod = getLayersByPeriod(for: provinceId, period: period)
        return layersInPeriod.first(where: { $0.type == type }) ?? layersInPeriod.first
    }

    private static func categorizeExtra(label: String) -> (PlanningType, PlanningPeriod) {
        let lower = label.lowercased()
        if lower.contains("1/2000") || lower.contains("phân khu") || lower.contains("qhpk") {
            return (.phanKhu, .qhKhac)
        } else if lower.contains("1/500") || lower.contains("chi tiết") {
            return (.chiTiet, .qhKhac)
        } else if lower.contains("xây dựng") || lower.contains("qhc") || lower.contains("chung") {
            return (.xayDung, .qhKhac)
        } else if lower.contains("giao thông") || lower.contains("metro") || lower.contains("đường") {
            return (.giaoThong, .qhKhac)
        } else if lower.contains("2030") {
            return (.sdd, .qh2030)
        } else if lower.contains("202") || lower.contains("kế hoạch") || lower.contains("kh ") {
            return (.sdd, .khHangNam)
        } else {
            return (.qhTinh, .qhKhac)
        }
    }

    private static func pickColor(for label: String, index: Int) -> String {
        let lower = label.lowercased()
        if lower.contains("phân khu") || lower.contains("1/2000") { return "#3B82F6" }
        if lower.contains("1/500") || lower.contains("chi tiết") { return "#6366F1" }
        if lower.contains("xây dựng") { return "#EC4899" }
        if lower.contains("giao thông") || lower.contains("đường") { return "#84CC16" }
        if lower.contains("sông") || lower.contains("nước") { return "#0284C7" }
        let palette = ["#8B5CF6", "#06B6D4", "#F59E0B", "#14B8A6", "#F43F5E", "#EAB308"]
        return palette[index % palette.count]
    }

    /// Danh sách layer cứng riêng cho Hà Nội — khớp 100% với Android GulandPlanningLayerRepository.kt trường hợp "hanoi".
    private static let hanoiLayers: [PlanningLayer] = [
        PlanningLayer(id: "hanoi-sdd-2030", provinceId: "hanoi", type: .sdd, period: .qh2030, label: "Quy hoạch 2030", tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ha-noi-2030-2/{z}/{x}/{y}.png", isVector: false, colorHex: "#F97316", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-100-nam", provinceId: "hanoi", type: .sdd, period: .qh2030, label: "Quy hoạch 100 năm", tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/hn-100-4/{z}/{x}/{y}.png", isVector: false, colorHex: "#8B5CF6", minZoom: 12, maxZoom: 22),
        PlanningLayer(id: "hanoi-pk-1500", provinceId: "hanoi", type: .chiTiet, period: .qhKhac, label: "Bản 1/500 - 1/2000", tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/hanoi-pk/{z}/{x}/{y}.png?v=779i", isVector: false, colorHex: "#3B82F6", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-song-hong", provinceId: "hanoi", type: .phanKhu, period: .qhKhac, label: "Quy hoạch Sông Hồng", tileUrlTemplate: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/hn-song-hong-lay-y-kien-79-2/{z}/{x}/{y}.png", isVector: false, colorHex: "#0284C7", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-qhc-2065", provinceId: "hanoi", type: .xayDung, period: .qhKhac, label: "QHC 2045 - 2065", tileUrlTemplate: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/hn-qhc/{z}/{x}/{y}.png?v=1235", isVector: false, colorHex: "#EC4899", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-metro", provinceId: "hanoi", type: .giaoThong, period: .qhKhac, label: "Phân khu Metro", tileUrlTemplate: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/hanoi-qhpk2/{z}/{x}/{y}.png", isVector: false, colorHex: "#EAB308", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-train-road", provinceId: "hanoi", type: .giaoThong, period: .qhKhac, label: "Quy hoạch giao thông", tileUrlTemplate: "https://s3-han02.fptcloud.com/guland5/ha-noi-train-road/{z}/{x}/{y}.png", isVector: false, colorHex: "#059669", minZoom: 5, maxZoom: 22),
        PlanningLayer(id: "hanoi-dia-chinh", provinceId: "hanoi", type: .chiTiet, period: .qhKhac, label: "Bản đồ Địa chính", tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ha-noi-dia-chinh-2/{z}/{x}/{y}.png", isVector: false, colorHex: "#6366F1", minZoom: 5, maxZoom: 22)
    ]
}

