import Foundation
import CoreLocation

/// Điểm tọa độ góc ranh hệ VN-2000 ghi trên sổ đỏ / trích lục địa chính
struct VN2000Point: Identifiable {
    let id = UUID()
    var order: Int               // Số thứ tự đỉnh (1, 2, 3...)
    var x: Double                // Tọa độ X (hướng Bắc) - ví dụ 2325500.25
    var y: Double                // Tọa độ Y (hướng Đông) - ví dụ 588200.50
    var convertedWGS84: CLLocationCoordinate2D? = nil // Tọa độ GPS tương ứng
}

/// Kết quả chuyển đổi đa giác ranh giới thửa đất từ VN-2000 sang WGS-84
struct VN2000PolygonResult: Identifiable {
    let id = UUID()
    let points: [VN2000Point]
    let coordinates: [CLLocationCoordinate2D]
    let areaSquareMeters: Double       // Diện tích tính từ các đỉnh (m²)
    let perimeterMeters: Double        // Chu vi thửa đất (m)
    let centerCoordinate: CLLocationCoordinate2D
    let provinceName: String
    let centralMeridian: Double
}
