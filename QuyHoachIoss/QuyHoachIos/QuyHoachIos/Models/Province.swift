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
struct PlanningLayer: Identifiable, Hashable {
    let id: String
    let provinceId: String
    let label: String
    let tileUrlTemplate: String
    var isVector: Bool = false
    var colorHex: String = "#3B82F6"
    var minZoom: Double = 8
    var maxZoom: Double = 19

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PlanningLayer, rhs: PlanningLayer) -> Bool {
        lhs.id == rhs.id
    }
}
