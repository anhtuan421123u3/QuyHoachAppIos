import Foundation

enum LandCategory: String, CaseIterable, Identifiable {
    case residential = "Đất ở"
    case commercial = "Đất thương mại & sản xuất"
    case agriculture = "Đất nông nghiệp & trồng trọt"
    case forestry = "Đất lâm nghiệp & rừng"
    case publicUtility = "Đất công cộng & hạ tầng"
    case special = "Đất an ninh & tôn giáo"

    var id: String { self.rawValue }
}

struct LandType: Identifiable, Hashable {
    let id = UUID()
    let code: String
    let name: String
    let hexColor: String
    let description: String
    let category: LandCategory
    var canConvertToResidential: Bool = true // Khả năng chuyển đổi lên đất ở ODT/ONT
    var legalReference: String = "Luật Đất Đai 2024"

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    static func == (lhs: LandType, rhs: LandType) -> Bool {
        lhs.code == rhs.code
    }
}
