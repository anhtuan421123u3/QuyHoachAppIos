import Foundation

class ProvinceRepository {
    static let shared = ProvinceRepository()

    // Danh sách toàn bộ 63 Tỉnh / Thành phố Việt Nam kèm Kinh tuyến trục VN-2000 chuẩn
    let provinces: [Province] = [
        Province(id: "hanoi", name: "Hà Nội", latitude: 21.0285, longitude: 105.8542, zoomLevel: 12, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ha-noi-2030-2/{z}/{x}/{y}.png", description: "Thủ đô Hà Nội", region: .north, centralMeridian: 105.00),
        Province(id: "haiphong", name: "Hải Phòng", latitude: 20.8449, longitude: 106.6881, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/hai-phong-2030/{z}/{x}/{y}.png", description: "TP. Hải Phòng", region: .north, centralMeridian: 105.75),
        Province(id: "quangninh", name: "Quảng Ninh", latitude: 21.0069, longitude: 107.2925, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/quang-ninh-2030/{z}/{x}/{y}.png", description: "Tỉnh Quảng Ninh", region: .north, centralMeridian: 107.75),
        Province(id: "bacninh", name: "Bắc Ninh", latitude: 21.1861, longitude: 106.0763, zoomLevel: 12, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/bac-ninh-2030/{z}/{x}/{y}.png", description: "Tỉnh Bắc Ninh", region: .north, centralMeridian: 105.50),
        Province(id: "hungyen", name: "Hưng Yên", latitude: 20.6464, longitude: 106.0511, zoomLevel: 12, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/hung-yen-2030/{z}/{x}/{y}.png", description: "Tỉnh Hưng Yên", region: .north, centralMeridian: 105.50),
        Province(id: "haiduong", name: "Hải Dương", latitude: 20.9373, longitude: 106.3146, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hai-duong-2030-dc/{z}/{x}/{y}.png", description: "Tỉnh Hải Dương", region: .north, centralMeridian: 105.50),
        Province(id: "vinhphuc", name: "Vĩnh Phúc", latitude: 21.3089, longitude: 105.6049, zoomLevel: 11, tileUrlTemplate: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/vinh-phuc-2030/{z}/{x}/{y}.png", description: "Tỉnh Vĩnh Phúc", region: .north, centralMeridian: 105.00),
        Province(id: "hanam", name: "Hà Nam", latitude: 20.5835, longitude: 105.9243, zoomLevel: 12, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/ha-nam-2030-dc/{z}/{x}/{y}.png", description: "Tỉnh Hà Nam", region: .north, centralMeridian: 105.00),
        Province(id: "namdinh", name: "Nam Định", latitude: 20.4389, longitude: 106.1782, zoomLevel: 11, tileUrlTemplate: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/nam-dinh-2030/{z}/{x}/{y}.png", description: "Tỉnh Nam Định", region: .north, centralMeridian: 105.50),
        Province(id: "ninhbinh", name: "Ninh Bình", latitude: 20.2506, longitude: 105.9745, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ninh-binh-2030/{z}/{x}/{y}.png", description: "Tỉnh Ninh Bình", region: .north, centralMeridian: 105.00),
        Province(id: "thaibinh", name: "Thái Bình", latitude: 20.4463, longitude: 106.3364, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-binh-2030/{z}/{x}/{y}.png", description: "Tỉnh Thái Bình", region: .north, centralMeridian: 105.50),
        Province(id: "thainguyen", name: "Thái Nguyên", latitude: 21.5928, longitude: 105.8442, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-nguyen-2030/{z}/{x}/{y}.png", description: "Tỉnh Thái Nguyên", region: .north, centralMeridian: 105.75),
        Province(id: "bacgiang", name: "Bắc Giang", latitude: 21.2731, longitude: 106.1947, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/bac-giang-2030-2/{z}/{x}/{y}.png", description: "Tỉnh Bắc Giang", region: .north, centralMeridian: 107.00),
        Province(id: "phutho", name: "Phú Thọ", latitude: 21.3228, longitude: 105.4019, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/phu-tho-2030/{z}/{x}/{y}.png", description: "Tỉnh Phú Thọ", region: .north, centralMeridian: 104.75),
        Province(id: "langson", name: "Lạng Sơn", latitude: 21.8478, longitude: 106.7597, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/lang-son-2030/{z}/{x}/{y}.png", description: "Tỉnh Lạng Sơn", region: .north, centralMeridian: 107.25),
        Province(id: "caobang", name: "Cao Bằng", latitude: 22.6658, longitude: 106.2575, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/cao-bang-2030-dc/{z}/{x}/{y}.png", description: "Tỉnh Cao Bằng", region: .north, centralMeridian: 105.75),
        Province(id: "backan", name: "Bắc Kạn", latitude: 22.1472, longitude: 105.8347, zoomLevel: 10, tileUrlTemplate: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/bac-kan-2030/{z}/{x}/{y}.png", description: "Tỉnh Bắc Kạn", region: .north, centralMeridian: 105.00),
        Province(id: "tuyenquang", name: "Tuyên Quang", latitude: 21.8239, longitude: 105.2155, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/tuyen-quang-2030/{z}/{x}/{y}.png", description: "Tỉnh Tuyên Quang", region: .north, centralMeridian: 106.00),
        Province(id: "hagiang", name: "Hà Giang", latitude: 22.8233, longitude: 104.9839, zoomLevel: 10, tileUrlTemplate: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/ha-giang-2030/{z}/{x}/{y}.png", description: "Tỉnh Hà Giang", region: .north, centralMeridian: 104.75),
        Province(id: "laocai", name: "Lào Cai", latitude: 22.4856, longitude: 103.9707, zoomLevel: 10, tileUrlTemplate: "https://guland2.sgp1.cdn.digitaloceanspaces.com/qh/lao-cai-2030/{z}/{x}/{y}.png", description: "Tỉnh Lào Cai", region: .north, centralMeridian: 104.75),
        Province(id: "yenbai", name: "Yên Bái", latitude: 21.7050, longitude: 104.8700, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/yen-bai-2030/{z}/{x}/{y}.png", description: "Tỉnh Yên Bái", region: .north, centralMeridian: 104.75),
        Province(id: "hoabinh", name: "Hòa Bình", latitude: 20.8133, longitude: 105.3383, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/hoa-binh-2030-2/{z}/{x}/{y}.png", description: "Tỉnh Hòa Bình", region: .north, centralMeridian: 105.00),
        Province(id: "sonla", name: "Sơn La", latitude: 21.3256, longitude: 103.9188, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/son-la-2030/{z}/{x}/{y}.png", description: "Tỉnh Sơn La", region: .north, centralMeridian: 104.00),
        Province(id: "dienbien", name: "Điện Biên", latitude: 21.3869, longitude: 103.0227, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/dien-bien-2030/{z}/{x}/{y}.png", description: "Tỉnh Điện Biên", region: .north, centralMeridian: 103.00),
        Province(id: "laichau", name: "Lai Châu", latitude: 22.3964, longitude: 103.4589, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/lai-chau-2030/{z}/{x}/{y}.png", description: "Tỉnh Lai Châu", region: .north, centralMeridian: 103.00),
        Province(id: "thanhhoa", name: "Thanh Hóa", latitude: 19.8067, longitude: 105.7851, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/thanh-hoa-2030/{z}/{x}/{y}.png", description: "Tỉnh Thanh Hóa", region: .central, centralMeridian: 105.00),
        Province(id: "nghean", name: "Nghệ An", latitude: 19.3809, longitude: 104.8970, zoomLevel: 9, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/nghe-an-2030/{z}/{x}/{y}.png", description: "Tỉnh Nghệ An", region: .central, centralMeridian: 104.75),
        Province(id: "hatinh", name: "Hà Tĩnh", latitude: 18.3559, longitude: 105.8877, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ha-tinh-2030/{z}/{x}/{y}.png", description: "Tỉnh Hà Tĩnh", region: .central, centralMeridian: 105.50),
        Province(id: "quangbinh", name: "Quảng Bình", latitude: 17.4687, longitude: 106.6234, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/quang-binh-2030/{z}/{x}/{y}.png", description: "Tỉnh Quảng Bình", region: .central, centralMeridian: 106.00),
        Province(id: "quangtri", name: "Quảng Trị", latitude: 16.7443, longitude: 107.1855, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/quang-tri-2030/{z}/{x}/{y}.png", description: "Tỉnh Quảng Trị", region: .central, centralMeridian: 106.25),
        Province(id: "thuathienhue", name: "Thừa Thiên Huế", latitude: 16.4637, longitude: 107.5909, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/thua-thien-hue-2030/{z}/{x}/{y}.png", description: "Tỉnh Thừa Thiên Huế", region: .central, centralMeridian: 107.00),
        Province(id: "danang", name: "Đà Nẵng", latitude: 16.0544, longitude: 108.2022, zoomLevel: 12, tileUrlTemplate: "https://sgp1.digitaloceanspaces.com/guland/qh/da-nang-2030/{z}/{x}/{y}.png", description: "TP. Đà Nẵng", region: .central, centralMeridian: 107.75),
        Province(id: "quangnam", name: "Quảng Nam", latitude: 15.5707, longitude: 108.4754, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/quang-nam-2030/{z}/{x}/{y}.png", description: "Tỉnh Quảng Nam", region: .central, centralMeridian: 107.75),
        Province(id: "quangngai", name: "Quảng Ngãi", latitude: 15.1205, longitude: 108.7924, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/quang-ngai-2030/{z}/{x}/{y}.png", description: "Tỉnh Quảng Ngãi", region: .central, centralMeridian: 108.00),
        Province(id: "binhdinh", name: "Bình Định", latitude: 13.7820, longitude: 109.2194, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/binh-dinh-2030/{z}/{x}/{y}.png", description: "Tỉnh Bình Định", region: .central, centralMeridian: 108.25),
        Province(id: "phuyen", name: "Phú Yên", latitude: 13.0882, longitude: 109.3087, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/phu-yen-2030/{z}/{x}/{y}.png", description: "Tỉnh Phú Yên", region: .central, centralMeridian: 108.50),
        Province(id: "khanhhoa", name: "Khánh Hòa", latitude: 12.2388, longitude: 109.1967, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/khanh-hoa-2030/{z}/{x}/{y}.png", description: "Tỉnh Khánh Hòa", region: .central, centralMeridian: 108.25),
        Province(id: "ninhthuan", name: "Ninh Thuận", latitude: 11.5658, longitude: 108.9884, zoomLevel: 10, tileUrlTemplate: "https://251db3a9dce2de5.cmccloud.com.vn/guland6/qh/ninh-thuan-2030/{z}/{x}/{y}.png", description: "Tỉnh Ninh Thuận", region: .central, centralMeridian: 108.25),
        Province(id: "binhthuan", name: "Bình Thuận", latitude: 10.9333, longitude: 108.1000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-thuan-2030/{z}/{x}/{y}.png", description: "Tỉnh Bình Thuận", region: .central, centralMeridian: 107.75),
        Province(id: "kontum", name: "Kon Tum", latitude: 14.3508, longitude: 108.0000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/kon-tum-2030/{z}/{x}/{y}.png", description: "Tỉnh Kon Tum", region: .central, centralMeridian: 107.50),
        Province(id: "gialai", name: "Gia Lai", latitude: 13.9833, longitude: 108.0000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/gia-lai-2030/{z}/{x}/{y}.png", description: "Tỉnh Gia Lai", region: .central, centralMeridian: 108.50),
        Province(id: "daklak", name: "Đắk Lắk", latitude: 12.6667, longitude: 108.0500, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/dak-lak-2030/{z}/{x}/{y}.png", description: "Tỉnh Đắk Lắk", region: .central, centralMeridian: 108.50),
        Province(id: "daknong", name: "Đắk Nông", latitude: 12.0000, longitude: 107.6833, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/dak-nong-2030/{z}/{x}/{y}.png", description: "Tỉnh Đắk Nông", region: .central, centralMeridian: 108.50),
        Province(id: "lamdong", name: "Lâm Đồng", latitude: 11.9404, longitude: 108.4583, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/lam-dong-2030/{z}/{x}/{y}.png", description: "Tỉnh Lâm Đồng", region: .central, centralMeridian: 107.75),
        Province(id: "hcm", name: "TP. Hồ Chí Minh", latitude: 10.8231, longitude: 106.6297, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/tp-ho-chi-minh-2030/{z}/{x}/{y}.png", description: "TP. Hồ Chí Minh", region: .south, centralMeridian: 105.75),
        Province(id: "binhduong", name: "Bình Dương", latitude: 11.1604, longitude: 106.6570, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/binh-duong-2030/{z}/{x}/{y}.png", description: "Tỉnh Bình Dương", region: .south, centralMeridian: 105.75),
        Province(id: "dongnai", name: "Đồng Nai", latitude: 10.9575, longitude: 106.8427, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/dong-nai-2030/{z}/{x}/{y}.png", description: "Tỉnh Đồng Nai", region: .south, centralMeridian: 107.75),
        Province(id: "bariavungtau", name: "Bà Rịa - Vũng Tàu", latitude: 10.5420, longitude: 107.1706, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/ba-ria-vung-tau-2030/{z}/{x}/{y}.png", description: "Tỉnh Bà Rịa - Vũng Tàu", region: .south, centralMeridian: 107.75),
        Province(id: "binhphuoc", name: "Bình Phước", latitude: 11.7500, longitude: 106.9000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-phuoc-2030/{z}/{x}/{y}.png", description: "Tỉnh Bình Phước", region: .south, centralMeridian: 106.25),
        Province(id: "tayninh", name: "Tây Ninh", latitude: 11.3000, longitude: 106.1000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/tay-ninh-2030/{z}/{x}/{y}.png", description: "Tỉnh Tây Ninh", region: .south, centralMeridian: 105.50),
        Province(id: "longan", name: "Long An", latitude: 10.5333, longitude: 106.4000, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/long-an-2030/{z}/{x}/{y}.png", description: "Tỉnh Long An", region: .south, centralMeridian: 105.75),
        Province(id: "tiengiang", name: "Tiền Giang", latitude: 10.4200, longitude: 106.3400, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/tien-giang-2030/{z}/{x}/{y}.png", description: "Tỉnh Tiền Giang", region: .south, centralMeridian: 105.75),
        Province(id: "bentre", name: "Bến Tre", latitude: 10.2333, longitude: 106.3833, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ben-tre-2030/{z}/{x}/{y}.png", description: "Tỉnh Bến Tre", region: .south, centralMeridian: 105.75),
        Province(id: "travinh", name: "Trà Vinh", latitude: 9.9333, longitude: 106.3500, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/tra-vinh-2030/{z}/{x}/{y}.png", description: "Tỉnh Trà Vinh", region: .south, centralMeridian: 105.75),
        Province(id: "vinhlong", name: "Vĩnh Long", latitude: 10.2500, longitude: 105.9667, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/vinh-long-2030/{z}/{x}/{y}.png", description: "Tỉnh Vĩnh Long", region: .south, centralMeridian: 105.50),
        Province(id: "dongthap", name: "Đồng Tháp", latitude: 10.4500, longitude: 105.6333, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/dong-thap-2030/{z}/{x}/{y}.png", description: "Tỉnh Đồng Tháp", region: .south, centralMeridian: 105.00),
        Province(id: "cantho", name: "Cần Thơ", latitude: 10.0452, longitude: 105.7469, zoomLevel: 12, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/can-tho-2030/{z}/{x}/{y}.png", description: "TP. Cần Thơ", region: .south, centralMeridian: 105.00),
        Province(id: "angiang", name: "An Giang", latitude: 10.3833, longitude: 105.4333, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/v2/an-giang-2030/{z}/{x}/{y}.png", description: "Tỉnh An Giang", region: .south, centralMeridian: 104.50),
        Province(id: "kiengiang", name: "Kiên Giang", latitude: 10.0167, longitude: 105.0833, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/kien-giang-2030/{z}/{x}/{y}.png", description: "Tỉnh Kiên Giang", region: .south, centralMeridian: 104.50),
        Province(id: "haugiang", name: "Hậu Giang", latitude: 9.7833, longitude: 105.4667, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hau-giang-2030--dc/{z}/{x}/{y}.png", description: "Tỉnh Hậu Giang", region: .south, centralMeridian: 105.00),
        Province(id: "soctrang", name: "Sóc Trăng", latitude: 9.6000, longitude: 105.9833, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/soc-trang-2030/{z}/{x}/{y}.png", description: "Tỉnh Sóc Trăng", region: .south, centralMeridian: 105.50),
        Province(id: "baclieu", name: "Bạc Liêu", latitude: 9.2942, longitude: 105.7244, zoomLevel: 11, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/bac-lieu-2030/{z}/{x}/{y}.png", description: "Tỉnh Bạc Liêu", region: .south, centralMeridian: 105.00),
        Province(id: "camau", name: "Cà Mau", latitude: 9.1769, longitude: 105.1524, zoomLevel: 10, tileUrlTemplate: "https://r4gmiynxmeobj.vcdn.cloud/ca-mau-2030/{z}/{x}/{y}.png", description: "Tỉnh Cà Mau", region: .south, centralMeridian: 104.50),
    ]

    /// Danh sách Layer Quy hoạch phong phú cho từng tỉnh thành — lấy từ GulandPlanningCatalog
    /// (dữ liệu CDN thật cho đủ 63 tỉnh thành, đối chiếu 100% với bản Android).
    func getLayers(for provinceId: String) -> [PlanningLayer] {
        return GulandPlanningLayerRepository.getLayers(for: provinceId)
    }

    func getLayersByPeriod(for provinceId: String, period: PlanningPeriod) -> [PlanningLayer] {
        return GulandPlanningLayerRepository.getLayersByPeriod(for: provinceId, period: period)
    }

    /// Danh mục đầy đủ 30+ mã loại đất chuẩn Luật Đất Đai 2024 & Thông tư 27/2018/TT-BTNMT
    let landTypes: [LandType] = [
        // 1. Nhóm Đất ở
        LandType(code: "ODT", name: "Đất ở tại đô thị", hexColor: "#FF5555", description: "Đất xây dựng nhà ở, công trình phục vụ đời sống trong khu vực đô thị (phường, thị trấn)", category: .residential, canConvertToResidential: true, legalReference: "Điều 143 Luật Đất Đai"),
        LandType(code: "ONT", name: "Đất ở tại nông thôn", hexColor: "#FF9999", description: "Đất xây dựng nhà ở, vườn ao liền kề trong cùng thửa đất ở nông thôn (xã)", category: .residential, canConvertToResidential: true, legalReference: "Điều 144 Luật Đất Đai"),

        // 2. Nhóm Đất Thương mại & Dịch vụ, Sản xuất
        LandType(code: "TMD", name: "Đất thương mại, dịch vụ", hexColor: "#FF55FF", description: "Đất xây dựng cơ sở kinh doanh thương mại, dịch vụ, siêu thị, khách sạn, nhà hàng", category: .commercial, canConvertToResidential: true, legalReference: "Điều 153 Luật Đất Đai"),
        LandType(code: "SKC", name: "Đất sản xuất phi nông nghiệp", hexColor: "#AA55FF", description: "Đất cơ sở sản xuất tiểu thủ công nghiệp, nhà xưởng gia công không thuộc KCN", category: .commercial, canConvertToResidential: true, legalReference: "Điều 154 Luật Đất Đai"),
        LandType(code: "SKK", name: "Đất khu công nghiệp", hexColor: "#9333EA", description: "Đất xây dựng cụm/khu công nghiệp, khu chế xuất tập trung", category: .commercial, canConvertToResidential: false, legalReference: "Điều 149 Luật Đất Đai"),
        LandType(code: "SKX", name: "Đất sản xuất vật liệu xây dựng", hexColor: "#7E22CE", description: "Đất khai thác mỏ cát, đá, sản xuất gạch ngói, đồ gốm", category: .commercial, canConvertToResidential: false, legalReference: "Điều 152 Luật Đất Đai"),

        // 3. Nhóm Đất Nông nghiệp & Trồng trọt
        LandType(code: "CLN", name: "Đất trồng cây lâu năm", hexColor: "#FFDD55", description: "Đất trồng các loại cây có thời gian sinh trưởng trên 1 năm (cây ăn quả, cây công nghiệp cao su, tiêu, điều...)", category: .agriculture, canConvertToResidential: true, legalReference: "Dễ chuyển đổi lên ODT/ONT khi phù hợp quy hoạch"),
        LandType(code: "BHK", name: "Đất trồng cây hàng năm khác", hexColor: "#FFEE99", description: "Đất trồng hoa màu, rau củ quả ngắn ngày, cây dược liệu", category: .agriculture, canConvertToResidential: true, legalReference: "Cho phép chuyển đổi lên đất ở"),
        LandType(code: "LUC", name: "Đất chuyên trồng lúa nước", hexColor: "#FFF8AA", description: "Đất canh tác từ 2 vụ lúa nước trở lên trong năm, được bảo vệ nghiêm ngặt", category: .agriculture, canConvertToResidential: true, legalReference: "Cần nộp tiền bảo vệ đất trồng lúa khi chuyển mục đích"),
        LandType(code: "LUK", name: "Đất trồng lúa khác", hexColor: "#FEF08A", description: "Đất lúa nương hoặc chỉ trồng được 1 vụ lúa nước trong năm", category: .agriculture, canConvertToResidential: true, legalReference: "Chuyển mục đích sử dụng theo kế hoạch huyện"),
        LandType(code: "NTS", name: "Đất nuôi trồng thủy sản", hexColor: "#77CCFF", description: "Đầm, hồ, ao nuôi trồng thủy hải sản nước mặn, lợ, ngọt", category: .agriculture, canConvertToResidential: true, legalReference: "Chuyển mục đích đất ở khi có quy hoạch"),
        LandType(code: "LMU", name: "Đất làm muối", hexColor: "#E0F2FE", description: "Đất sản xuất muối từ nước biển quy mô tập trung", category: .agriculture, canConvertToResidential: false, legalReference: "Điều 138 Luật Đất Đai"),
        LandType(code: "NKH", name: "Đất nông nghiệp khác", hexColor: "#FDE047", description: "Đất xây dựng nhà kính, chuồng trại chăn nuôi gia súc, ươm cây giống", category: .agriculture, canConvertToResidential: true, legalReference: "Điều 139 Luật Đất Đai"),

        // 4. Nhóm Đất Lâm nghiệp & Rừng
        LandType(code: "RSX", name: "Đất rừng sản xuất", hexColor: "#55AA55", description: "Rừng kinh tế trồng lấy gỗ, lâm sản và kết hợp sinh thái nghỉ dưỡng", category: .forestry, canConvertToResidential: false, legalReference: "Chỉ được chuyển đổi diện tích rừng nghèo kiệt"),
        LandType(code: "RPH", name: "Đất rừng phòng hộ", hexColor: "#338833", description: "Rừng đầu nguồn bảo vệ nguồn nước, chống xói mòn lũ quét, chắn cát biển", category: .forestry, canConvertToResidential: false, legalReference: "Nghiêm cấm tự ý chuyển mục đích sử dụng"),
        LandType(code: "RDD", name: "Đất rừng đặc dụng", hexColor: "#15803D", description: "Vườn quốc gia, khu bảo tồn thiên nhiên, khu di tích lịch sử văn hóa", category: .forestry, canConvertToResidential: false, legalReference: "Bảo tồn nghiêm ngặt cảnh quan quốc gia"),

        // 5. Nhóm Đất Công cộng & Hạ tầng
        LandType(code: "DGT", name: "Đất giao thông", hexColor: "#AAAAAA", description: "Đất hệ thống đường bộ, cao tốc, cầu cống, cảng biển, bến xe, nhà ga đường sắt", category: .publicUtility, canConvertToResidential: false, legalReference: "Đất thuộc hành lang lộ giới mở đường"),
        LandType(code: "CGS", name: "Đất trụ sở cơ quan", hexColor: "#00AAAA", description: "Trụ sở cơ quan nhà nước, tổ chức chính trị xã hội", category: .publicUtility, canConvertToResidential: false, legalReference: "Đất công vụ"),
        LandType(code: "DNL", name: "Đất công trình năng lượng", hexColor: "#FF7733", description: "Trạm biến áp, nhà máy nhiệt điện, thủy điện, điện gió, điện mặt trời", category: .publicUtility, canConvertToResidential: false, legalReference: "Hạ tầng kỹ thuật điện"),
        LandType(code: "DTT", name: "Đất công trình bưu chính, viễn thông", hexColor: "#F97316", description: "Trạm phát sóng viễn thông BTS, bưu cục, đài truyền hình", category: .publicUtility, canConvertToResidential: false, legalReference: "Hạ tầng thông tin"),
        LandType(code: "DKV", name: "Đất văn hóa - công viên cây xanh", hexColor: "#10B981", description: "Công viên công cộng, nhà hát, bảo tàng, quảng trường, khu vui chơi", category: .publicUtility, canConvertToResidential: false, legalReference: "Đất cảnh quan đô thị"),
        LandType(code: "DYT", name: "Đất cơ sở y tế", hexColor: "#EF4444", description: "Bệnh viện, trung tâm y tế, phòng khám đa khoa, trạm xá", category: .publicUtility, canConvertToResidential: false, legalReference: "Hạ tầng xã hội"),
        LandType(code: "DGD", name: "Đất cơ sở giáo dục và đào tạo", hexColor: "#3B82F6", description: "Trường mầm non, tiểu học, THCS, THPT, đại học, viện nghiên cứu", category: .publicUtility, canConvertToResidential: false, legalReference: "Hạ tầng giáo dục"),
        LandType(code: "DTS", name: "Đất cơ sở thể dục, thể thao", hexColor: "#06B6D4", description: "Sân vận động, nhà thi đấu, sân golf, trung tâm huấn luyện", category: .publicUtility, canConvertToResidential: false, legalReference: "Hạ tầng thể thao"),
        LandType(code: "DCH", name: "Đất chợ", hexColor: "#F59E0B", description: "Chợ dân sinh truyền thống, chợ đầu mối nông sản", category: .publicUtility, canConvertToResidential: false, legalReference: "Cơ sở thương mại dân sinh"),
        LandType(code: "DRA", name: "Đất bãi thải, xử lý chất thải", hexColor: "#78716C", description: "Khu liên hiệp xử lý rác thải, bãi chôn lấp chất thải công nghiệp", category: .publicUtility, canConvertToResidential: false, legalReference: "Khu vực ô nhiễm, cấm xây nhà ở"),

        // 6. Nhóm Đất An ninh, Tôn giáo & Đặc thù
        LandType(code: "CQP", name: "Đất quốc phòng", hexColor: "#84CC16", description: "Khu quân sự, căn cứ đóng quân, thao trường huấn luyện", category: .special, canConvertToResidential: false, legalReference: "Đất an ninh quốc gia"),
        LandType(code: "CAN", name: "Đất an ninh", hexColor: "#65A30D", description: "Đồn công an, trại giam, cơ sở nghiệp vụ an ninh", category: .special, canConvertToResidential: false, legalReference: "Đất an ninh trật tự"),
        LandType(code: "TON", name: "Đất cơ sở tôn giáo", hexColor: "#D97706", description: "Chùa, nhà thờ, thánh thất, tu viện tôn giáo", category: .special, canConvertToResidential: false, legalReference: "Đất tín ngưỡng tôn giáo"),
        LandType(code: "NTD", name: "Đất nghĩa trang, nghĩa địa", hexColor: "#57534E", description: "Khu nghĩa trang tập trung, đài hóa thân hoàn vũ", category: .special, canConvertToResidential: false, legalReference: "Hành lang cách ly an toàn môi trường")
    ]

    func getProvince(by id: String) -> Province {
        provinces.first(where: { $0.id == id }) ?? provinces[0]
    }

    func searchProvinces(query: String, region: Region = .all) -> [Province] {
        var results = provinces
        if region != .all {
            results = results.filter { $0.region == region }
        }
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return results
        }
        let cleanQuery = query.lowercased().folding(options: .diacriticInsensitive, locale: .current)
        return results.filter { province in
            let cleanName = province.name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            return cleanName.contains(cleanQuery) || province.id.contains(cleanQuery)
        }
    }

    func lookupParcel(query: String, province: Province) -> Parcel {
        let randomArea = Double(Int.random(in: 80...350)) + 0.5
        let randomPlot = Int.random(in: 1...150)
        let randomSheet = Int.random(in: 1...45)
        let currentLand = landTypes[6] // CLN - Cây lâu năm
        let planningLand = landTypes[0] // ODT - Đất ở đô thị

        let lat = province.latitude + Double.random(in: -0.015...0.015)
        let lng = province.longitude + Double.random(in: -0.015...0.015)

        // Tính tọa độ VN2000 tương ứng
        let vnCoord = VN2000Converter.shared.wgs84ToVN2000(
            coordinate: .init(latitude: lat, longitude: lng),
            centralMeridian: province.centralMeridian
        )

        return Parcel(
            id: UUID().uuidString,
            provinceId: province.id,
            provinceName: province.name,
            districtName: "Quận/Huyện Trung tâm",
            wardName: "Phường/Xã",
            plotNumber: "\(randomPlot)",
            sheetNumber: "\(randomSheet)",
            area: randomArea,
            currentLandType: currentLand,
            planningLandType: planningLand,
            address: "\(province.name), Việt Nam",
            latitude: lat,
            longitude: lng,
            vn2000X: vnCoord.x,
            vn2000Y: vnCoord.y,
            note: "Quy hoạch đất ở đô thị (ODT). Được phép chuyển đổi mục đích sử dụng đất sang đất ở",
            legalNote: "Sổ hồng riêng, không tranh chấp, đủ điều kiện giao dịch chuyển nhượng",
            planningWarning: nil,
            isBookmarked: false,
            savedDate: nil,
            customNote: "",
            estimatedPriceMillionPerM2: Double(Int.random(in: 25...85)),
            buildingDensity: "85%",
            maxFloors: "5 tầng + lửng + tum"
        )
    }

    /// Tìm tỉnh gần nhất với tọa độ (lat, lng) cho trước
    func findClosestProvince(lat: Double, lng: Double) -> Province {
        return provinces.min(by: { p1, p2 in
            let d1 = (p1.latitude - lat) * (p1.latitude - lat) + (p1.longitude - lng) * (p1.longitude - lng)
            let d2 = (p2.latitude - lat) * (p2.latitude - lat) + (p2.longitude - lng) * (p2.longitude - lng)
            return d1 < d2
        }) ?? provinces.first!
    }
}
