import Foundation
import CoreLocation

struct Parcel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var provinceId: String = "hanoi"
    var provinceName: String = "Hà Nội"
    var districtName: String = "Cầu Giấy"
    var wardName: String = "Dịch Vọng"
    var plotNumber: String = "45"          // Số thửa đất
    var sheetNumber: String = "18"         // Số tờ bản đồ
    var area: Double = 120.5               // Diện tích (m²)
    var currentLandType: LandType
    var planningLandType: LandType
    var address: String = "Hà Nội, Việt Nam"
    var latitude: Double = 21.0285
    var longitude: Double = 105.8542
    var vn2000X: Double? = nil             // Tọa độ VN-2000 X
    var vn2000Y: Double? = nil             // Tọa độ VN-2000 Y
    var note: String = "Quy hoạch đất ở đô thị"
    var legalNote: String = "Đủ điều kiện cấp sổ hồng, được phép chuyển nhượng & xây dựng"
    var planningWarning: String? = nil     // Cảnh báo (ví dụ: dính hành lang lộ giới 2m)
    var isBookmarked: Bool = false
    var savedDate: Date? = nil
    var customNote: String = ""            // Ghi chú riêng của người dùng
    var estimatedPriceMillionPerM2: Double = 45.0 // Giá tham khảo thị trường (triệu/m²)
    var buildingDensity: String = "85%"    // Mật độ xây dựng tối đa
    var maxFloors: String = "5 tầng + 1 lửng + tum" // Chiều cao công trình cho phép

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var landTypeCode: String {
        planningLandType.code
    }

    var landTypeName: String {
        planningLandType.name
    }

    var planningStatus: String {
        note
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Parcel, rhs: Parcel) -> Bool {
        lhs.id == rhs.id
    }
}
