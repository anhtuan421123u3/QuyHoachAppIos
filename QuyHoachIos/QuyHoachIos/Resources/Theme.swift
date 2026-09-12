import SwiftUI

// MARK: - Dark Glassmorphism Color System
// Chuẩn 100% đồng bộ với Android (DarkPanelBg, GreenAccent) và Web (LayerControlPanel.jsx)

struct AppTheme {
    // === Nền tối chuẩn Dark Glassmorphism ===
    static let darkBg         = Color(hex: "#12161D")
    static let darkPanelBg    = Color(hex: "#1A1F26")
    static let darkItemBg     = Color(hex: "#222831")
    static let darkBorder     = Color(hex: "#2E3742")

    // === Accent chủ đạo - Xanh Ngọc Lục Bảo phát sáng ===
    static let greenAccent    = Color(hex: "#00E676")
    static let greenGlow      = Color(hex: "#06F908")
    static let greenDim       = Color(hex: "#10B981")

    // === Text ===
    static let textLight      = Color(hex: "#F1F5F9")
    static let textMuted      = Color(hex: "#94A3B8")

    // === Accent phụ ===
    static let blueAccent     = Color(hex: "#38BDF8")
    static let redAccent      = Color(hex: "#EF4444")
}

// MARK: - Color Extension (hex init)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Bảng Ghi Chú Màu Quy Hoạch (chuẩn Android LayerControlDrawer.kt)
struct LegendColorItem {
    let name: String
    let colorHex: String
}

let qhLandUseLegend: [LegendColorItem] = [
    LegendColorItem(name: "Cây xanh, TDTT",       colorHex: "#06F908"),
    LegendColorItem(name: "Cây xanh công cộng",    colorHex: "#66CC00"),
    LegendColorItem(name: "Hồ, ao, đầm",           colorHex: "#004C99"),
    LegendColorItem(name: "Sông, kênh, rạch",      colorHex: "#0066CC"),
    LegendColorItem(name: "Đất ở đô thị",          colorHex: "#CC9900"),
    LegendColorItem(name: "Đất hỗn hợp",           colorHex: "#CC3300"),
    LegendColorItem(name: "Nhóm nhà xây mới",      colorHex: "#9B9B53"),
    LegendColorItem(name: "Đất làng xóm",          colorHex: "#E5BB40"),
]
