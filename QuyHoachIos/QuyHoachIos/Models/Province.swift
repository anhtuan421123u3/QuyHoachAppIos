import Foundation
import CoreLocation

enum Region: String, CaseIterable, Identifiable {
    case all = "Tất cả"
    case north = "Miền Bắc"
    case central = "Miền Trung"
    case south = "Miền Nam"

    var id: String { self.rawValue }
}

struct Province: Identifiable, Hashable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let zoomLevel: Double
    let tileUrlTemplate: String
    let description: String
    let region: Region
    var centralMeridian: Double = 105.0 // Kinh tuyến trục VN-2000 chuẩn

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Province, rhs: Province) -> Bool {
        lhs.id == rhs.id
    }
}

/// Mô hình một lớp bản đồ quy hoạch (hỗ trợ cả Vector MVT Protobuf và Raster VCDN/CMC/FPT)
enum PlanningType: String, CaseIterable, Identifiable {
    case sdd = "Sử dụng đất"
    case xayDung = "Xây dựng chung"
    case phanKhu = "Phân khu (1/2000)"
    case chiTiet = "Chi tiết (1/500)"
    case giaoThong = "Giao thông"
    case qhTinh = "QH tỉnh"

    var id: String { self.rawValue }
}

enum PlanningPeriod: String, CaseIterable, Identifiable {
    case qh2030 = "QH 2030"
    case khHangNam = "KH 2026"
    case qhKhac = "QH khác"

    var id: String { self.rawValue }
}

struct PlanningLayer: Identifiable, Hashable {
    let id: String
    let provinceId: String
    var type: PlanningType = .sdd
    var period: PlanningPeriod = .qh2030
    let label: String
    let tileUrlTemplate: String
    var isVector: Bool = false
    var colorHex: String = "#3B82F6"
    var minZoom: Double = 5
    var maxZoom: Double = 22

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PlanningLayer, rhs: PlanningLayer) -> Bool {
        lhs.id == rhs.id
    }
}

/// Dữ liệu cho hộp thoại hỏi người dùng có muốn di chuyển đến vị trí nhận được từ link / tìm kiếm không
struct LocationPrompt: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var zoom: Double? = nil
    var layerIds: [String] = []
    var source: String = "Liên kết"
}

