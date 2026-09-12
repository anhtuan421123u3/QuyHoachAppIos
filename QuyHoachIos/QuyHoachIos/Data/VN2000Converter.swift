import Foundation
import CoreLocation

/// Bộ công cụ tính toán & chuyển đổi tọa độ hệ quy chiếu Quốc gia VN-2000 sang WGS-84 (GPS)
/// Triển khai theo thuật toán Gauss-Krüger / Transverse Mercator và 7 tham số Helmert
/// Chuẩn Quyết định số 05/2007/QĐ-BTNMT của Bộ Tài nguyên & Môi trường Việt Nam.
class VN2000Converter {
    static let shared = VN2000Converter()

    // Hằng số Ellipsoid WGS-84 / VN-2000
    private let a: Double = 6378137.0                      // Bán trục lớn (m)
    private let f: Double = 1.0 / 298.257223563            // Độ dẹt
    private var b: Double { a * (1.0 - f) }                // Bán trục bé (m)
    private var e2: Double { 2.0 * f - f * f }             // Độ lệch tâm thứ nhất bình phương
    private var e_prime2: Double { e2 / (1.0 - e2) }       // Độ lệch tâm thứ hai bình phương

    // 7 Tham số chuyển đổi Helmert (VN-2000 -> WGS-84) theo QĐ 05/2007/QĐ-BTNMT
    private let dx: Double = -191.90441429                 // Dịch chuyển trục X (m)
    private let dy: Double = -39.30318279                  // Dịch chuyển trục Y (m)
    private let dz: Double = -111.45032835                 // Dịch chuyển trục Z (m)
    private let wx: Double = -0.00928836 * (.pi / (180.0 * 3600.0)) // Góc xoay X (rad)
    private let wy: Double = 0.01975479 * (.pi / (180.0 * 3600.0))  // Góc xoay Y (rad)
    private let wz: Double = -0.00427372 * (.pi / (180.0 * 3600.0)) // Góc xoay Z (rad)
    private let ms: Double = (1.0 + 0.0000002529829)       // Tỉ lệ scale (m)

    /// Chuyển đổi từ tọa độ VN-2000 (X, Y) sang tọa độ GPS WGS-84 (Latitude, Longitude)
    /// - Parameters:
    ///   - x: Tọa độ X (hướng Bắc / Northing) theo mét
    ///   - y: Tọa độ Y (hướng Đông / Easting) theo mét (thường có tiền tố 500xxx)
    ///   - centralMeridian: Kinh tuyến trục của tỉnh (độ thập phân, ví dụ Hà Nội là 105.0, TP.HCM là 105.75)
    ///   - zone3: `true` nếu múi chiếu 3 độ (hệ số scale k0 = 0.9999, dùng trên sổ đỏ), `false` nếu múi 6 độ (k0 = 0.9996)
    func vn2000ToWGS84(x: Double, y: Double, centralMeridian: Double, zone3: Bool = true) -> CLLocationCoordinate2D {
        let k0 = zone3 ? 0.9999 : 0.9996
        let x0 = 0.0
        let y0 = 500000.0
        let l0 = centralMeridian * .pi / 180.0

        let x_calc = x - x0
        let y_calc = y - y0

        // 1. Phép chiếu nghịch Transverse Mercator (x, y -> B, L trong hệ VN2000)
        let m = x_calc / k0
        let e1 = (1.0 - sqrt(1.0 - e2)) / (1.0 + sqrt(1.0 - e2))
        let mu = m / (a * (1.0 - e2 / 4.0 - 3.0 * e2 * e2 / 64.0 - 5.0 * pow(e2, 3) / 256.0))

        let phi1 = mu +
            (3.0 * e1 / 2.0 - 27.0 * pow(e1, 3) / 32.0) * sin(2.0 * mu) +
            (21.0 * e1 * e1 / 16.0 - 55.0 * pow(e1, 4) / 32.0) * sin(4.0 * mu) +
            (151.0 * pow(e1, 3) / 96.0) * sin(6.0 * mu) +
            (1097.0 * pow(e1, 4) / 512.0) * sin(8.0 * mu)

        let sinPhi1 = sin(phi1)
        let cosPhi1 = cos(phi1)
        let tanPhi1 = tan(phi1)

        let n1 = a / sqrt(1.0 - e2 * sinPhi1 * sinPhi1)
        let t1 = tanPhi1 * tanPhi1
        let c1 = e_prime2 * cosPhi1 * cosPhi1
        let r1 = a * (1.0 - e2) / pow(1.0 - e2 * sinPhi1 * sinPhi1, 1.5)
        let d = y_calc / (n1 * k0)

        let latVN = phi1 - (n1 * tanPhi1 / r1) * (
            d * d / 2.0 -
            (5.0 + 3.0 * t1 + 10.0 * c1 - 4.0 * c1 * c1 - 9.0 * e_prime2) * pow(d, 4) / 24.0 +
            (61.0 + 90.0 * t1 + 298.0 * c1 + 45.0 * t1 * t1 - 252.0 * e_prime2 - 3.0 * c1 * c1) * pow(d, 6) / 720.0
        )

        let lonVN = l0 + (
            d -
            (1.0 + 2.0 * t1 + c1) * pow(d, 3) / 6.0 +
            (5.0 - 2.0 * c1 + 28.0 * t1 - 3.0 * c1 * c1 + 8.0 * e_prime2 + 24.0 * t1 * t1) * pow(d, 5) / 120.0
        ) / cosPhi1

        // 2. Chuyển đổi trắc địa sang địa tâm XYZ (VN-2000)
        let sinLatVN = sin(latVN)
        let cosLatVN = cos(latVN)
        let sinLonVN = sin(lonVN)
        let cosLonVN = cos(lonVN)

        let n = a / sqrt(1.0 - e2 * sinLatVN * sinLatVN)
        let h: Double = 0.0 // Giả định độ cao mặt đất chuẩn h = 0

        let x_geo = (n + h) * cosLatVN * cosLonVN
        let y_geo = (n + h) * cosLatVN * sinLonVN
        let z_geo = (n * (1.0 - e2) + h) * sinLatVN

        // 3. Phép biến đổi 7 tham số Helmert (VN2000 -> WGS84)
        let x_wgs = dx + ms * (x_geo + wz * y_geo - wy * z_geo)
        let y_wgs = dy + ms * (-wz * x_geo + y_geo + wx * z_geo)
        let z_wgs = dz + ms * (wy * x_geo - wx * y_geo + z_geo)

        // 4. Chuyển ngược từ XYZ địa tâm WGS84 sang Vĩ độ / Kinh độ WGS84
        let p = sqrt(x_wgs * x_wgs + y_wgs * y_wgs)
        let theta = atan2(z_wgs * a, p * b)

        let sinTheta = sin(theta)
        let cosTheta = cos(theta)

        let latWGS = atan2(
            z_wgs + e_prime2 * b * pow(sinTheta, 3),
            p - e2 * a * pow(cosTheta, 3)
        )
        let lonWGS = atan2(y_wgs, x_wgs)

        let finalLat = latWGS * 180.0 / .pi
        let finalLon = lonWGS * 180.0 / .pi

        return CLLocationCoordinate2D(latitude: finalLat, longitude: finalLon)
    }

    /// Chuyển đổi từ GPS WGS-84 sang VN-2000 (X, Y)
    func wgs84ToVN2000(coordinate: CLLocationCoordinate2D, centralMeridian: Double, zone3: Bool = true) -> (x: Double, y: Double) {
        let latRad = coordinate.latitude * .pi / 180.0
        let lonRad = coordinate.longitude * .pi / 180.0

        // 1. WGS84 Geodetic to Geocentric XYZ
        let sinLat = sin(latRad)
        let cosLat = cos(latRad)
        let sinLon = sin(lonRad)
        let cosLon = cos(lonRad)

        let n = a / sqrt(1.0 - e2 * sinLat * sinLat)
        let x_wgs = n * cosLat * cosLon
        let y_wgs = n * cosLat * sinLon
        let z_wgs = n * (1.0 - e2) * sinLat

        // 2. Inverse Helmert (WGS84 -> VN2000)
        let x_geo = (-dx + x_wgs - wz * y_wgs + wy * z_wgs) / ms
        let y_geo = (-dy + wz * x_wgs + y_wgs - wx * z_wgs) / ms
        let z_geo = (-dz - wy * x_wgs + wx * y_wgs + z_wgs) / ms

        // 3. Geocentric XYZ to VN2000 Geodetic Lat/Lon
        let p = sqrt(x_geo * x_geo + y_geo * y_geo)
        let theta = atan2(z_geo * a, p * b)
        let latVN = atan2(
            z_geo + e_prime2 * b * pow(sin(theta), 3),
            p - e2 * a * pow(cos(theta), 3)
        )
        let lonVN = atan2(y_geo, x_geo)

        // 4. Forward Transverse Mercator Projection (Lat, Lon -> X, Y VN2000)
        let k0 = zone3 ? 0.9999 : 0.9996
        let l0 = centralMeridian * .pi / 180.0
        let dLon = lonVN - l0

        let sinLatVN = sin(latVN)
        let cosLatVN = cos(latVN)
        let tanLatVN = tan(latVN)

        let n1 = a / sqrt(1.0 - e2 * sinLatVN * sinLatVN)
        let t1 = tanLatVN * tanLatVN
        let c1 = e_prime2 * cosLatVN * cosLatVN

        // Meridian arc
        let m = a * (
            (1.0 - e2 / 4.0 - 3.0 * e2 * e2 / 64.0 - 5.0 * pow(e2, 3) / 256.0) * latVN -
            (3.0 * e2 / 8.0 + 3.0 * e2 * e2 / 32.0 + 45.0 * pow(e2, 3) / 1024.0) * sin(2.0 * latVN) +
            (15.0 * e2 * e2 / 256.0 + 45.0 * pow(e2, 3) / 1024.0) * sin(4.0 * latVN) -
            (35.0 * pow(e2, 3) / 3072.0) * sin(6.0 * latVN)
        )

        let x = k0 * (
            m + n1 * tanLatVN * (
                pow(dLon, 2) * cosLatVN * cosLatVN / 2.0 +
                pow(dLon, 4) * pow(cosLatVN, 4) * (5.0 - t1 + 9.0 * c1 + 4.0 * c1 * c1) / 24.0 +
                pow(dLon, 6) * pow(cosLatVN, 6) * (61.0 - 58.0 * t1 + t1 * t1 + 600.0 * c1 - 330.0 * e_prime2) / 720.0
            )
        )

        let y = 500000.0 + k0 * n1 * (
            dLon * cosLatVN +
            pow(dLon, 3) * pow(cosLatVN, 3) * (1.0 - t1 + c1) / 6.0 +
            pow(dLon, 5) * pow(cosLatVN, 5) * (5.0 - 18.0 * t1 + t1 * t1 + 72.0 * c1 - 58.0 * e_prime2) / 120.0
        )

        return (x: x, y: y)
    }

    /// Phân tích chuỗi văn bản danh sách tọa độ (paste từ sổ đỏ hoặc nhập nhiều dòng)
    /// Hỗ trợ nhiều định dạng phổ biến:
    /// `1  2325500.50  588200.20`
    /// `X: 2325500.5, Y: 588200.2`
    /// `2325500.5, 588200.2`
    func parsePointsFromText(_ text: String, centralMeridian: Double, zone3: Bool = true) -> [VN2000Point] {
        var points: [VN2000Point] = []
        let lines = text.components(separatedBy: .newlines)

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { continue }

            // Tách các số trong dòng bằng dấu cách, tab, phẩy hoặc chấm phẩy
            let separators = CharacterSet(charactersIn: " \t,;:/|")
            let tokens = trimmed.components(separatedBy: separators).filter { !$0.isEmpty }

            // Lọc các giá trị số hợp lệ
            var numbers: [Double] = []
            for token in tokens {
                let clean = token.replacingOccurrences(of: "X=", with: "")
                    .replacingOccurrences(of: "Y=", with: "")
                    .replacingOccurrences(of: "x=", with: "")
                    .replacingOccurrences(of: "y=", with: "")
                    .replacingOccurrences(of: "X:", with: "")
                    .replacingOccurrences(of: "Y:", with: "")
                if let num = Double(clean) {
                    numbers.append(num)
                }
            }

            if numbers.count >= 2 {
                // Nhận diện: nếu có 3 số (thường là: Stt, X, Y)
                let xVal: Double
                let yVal: Double
                let orderVal: Int

                if numbers.count >= 3 {
                    orderVal = Int(numbers[0])
                    xVal = numbers[1]
                    yVal = numbers[2]
                } else {
                    orderVal = points.count + 1
                    xVal = numbers[0]
                    yVal = numbers[1]
                }

                // Tự động phân biệt nếu người dùng nhập ngược Y trước X sau (X ở VN thường từ 900.000 đến 2.600.000, Y từ 300.000 đến 800.000)
                let actualX = (xVal < 1000000 && yVal > 1000000) ? yVal : xVal
                let actualY = (xVal < 1000000 && yVal > 1000000) ? xVal : yVal

                let wgs = vn2000ToWGS84(x: actualX, y: actualY, centralMeridian: centralMeridian, zone3: zone3)
                points.append(VN2000Point(order: orderVal, x: actualX, y: actualY, convertedWGS84: wgs))
            }
        }

        return points
    }

    /// Tính toán đa giác ranh giới thửa đất từ danh sách điểm VN2000
    func createPolygon(from points: [VN2000Point], provinceName: String, centralMeridian: Double) -> VN2000PolygonResult? {
        guard points.count >= 3 else { return nil }

        let coords = points.compactMap { $0.convertedWGS84 }
        guard coords.count == points.count else { return nil }

        // Tính diện tích đa giác theo công thức Shoelace (Gauss Area formula) bằng mét thực tế
        var area: Double = 0.0
        var perimeter: Double = 0.0
        let n = points.count

        for i in 0..<n {
            let j = (i + 1) % n
            area += (points[i].x * points[j].y) - (points[j].x * points[i].y)

            let dx = points[j].x - points[i].x
            let dy = points[j].y - points[i].y
            perimeter += sqrt(dx * dx + dy * dy)
        }
        area = abs(area) / 2.0

        // Tính tâm trọng tâm đa giác
        let avgLat = coords.map { $0.latitude }.reduce(0, +) / Double(coords.count)
        let avgLng = coords.map { $0.longitude }.reduce(0, +) / Double(coords.count)

        return VN2000PolygonResult(
            points: points,
            coordinates: coords,
            areaSquareMeters: area,
            perimeterMeters: perimeter,
            centerCoordinate: CLLocationCoordinate2D(latitude: avgLat, longitude: avgLng),
            provinceName: provinceName,
            centralMeridian: centralMeridian
        )
    }
}
