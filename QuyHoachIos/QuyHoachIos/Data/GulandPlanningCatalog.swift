// AUTO-GENERATED from Android GulandPlanningCatalog.kt — DO NOT EDIT BY HAND
// Metadata quy hoạch thực tế từ Guland CDN cho toàn bộ 63 tỉnh thành Việt Nam.
import Foundation

struct GulandExtraLayer {
    let label: String
    let url: String
    let typeCode: String
}

struct GulandProvinceInfo {
    let id: String
    let name: String
    let slug: String
    let qh2030: String?
    let khHangNam: String?
    let layerLand: String?
    var maxNativeZoom: Int = 18
    var extraLayers: [GulandExtraLayer] = []
}

enum GulandPlanningCatalog {
    static let provincesData: [String: GulandProvinceInfo] = [
        "hanoi": GulandProvinceInfo(
            id: "hanoi",
            name: "Hà Nội",
            slug: "ha-noi",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/ha-noi-2030-2/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/hanoi-qhpk2/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/ha-noi/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 1/500, 1/2000", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/hanoi-pk/{z}/{x}/{y}.png?v=779i", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH Sông Hồng (LYK 7/9)", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/hn-song-hong-lay-y-kien-79-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 100 năm", url: "https://r4gmiynxmeobj.vcdn.cloud/hn-100-4/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 2045-2065", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/hn-qhc/{z}/{x}/{y}.png?v=1235", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/hanoi-qhpk2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "Metro (Tham khảo)", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/hanoi-metro/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/ha-noi-2030-2/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH Olympic", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-olympic-3/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/hanoi-qhpk2/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "haiphong": GulandProvinceInfo(
            id: "haiphong",
            name: "Hải Phòng",
            slug: "hai-phong",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/hai-phong-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/hai-phong/quan-le-chan--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/hai-phong-3/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/hai-phong-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hai-phong--qhc-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/500 - 1/2000", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/hai-phong--qhpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/hai-phong/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-han02.fptcloud.com/guland5/qhxd/hai-phong/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/hai-phong/quan-le-chan--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-han02.fptcloud.com/guland5/qhxd/hai-phong/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "quangninh": GulandProvinceInfo(
            id: "quangninh",
            name: "Quảng Ninh",
            slug: "quang-ninh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/quang-ninh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/quang-ninh/thanh-pho-cam-pha--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/quang-ninh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-ninh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/quang-ninh--qhc-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/quang-ninh--qhpk-3/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/quang-ninh/thanh-pho-cam-pha--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-ninh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "bacninh": GulandProvinceInfo(
            id: "bacninh",
            name: "Bắc Ninh",
            slug: "bac-ninh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/bac-ninh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/bac-ninh/thanh-pho-bac-ninh/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/bac-ninh-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/bac-ninh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH 1/500 - 1/2000", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/bac-ninh--qhpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/bac-ninh-qhpk-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/bac-ninh/tp-bac-ninh--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/bac-ninh--qhxdpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/bac-ninh/thanh-pho-bac-ninh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland10/qh-khac/bac-ninh/do-thi-bac-ninh--45dc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland10/qh-khac/bac-ninh/do-thi-bac-ninh--45dc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_qhxd"),
            ]
        ),
        "hungyen": GulandProvinceInfo(
            id: "hungyen",
            name: "Hưng Yên",
            slug: "hung-yen",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/hung-yen-2030/{z}/{x}/{y}.png",
            khHangNam: nil,
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/hung-yen-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland7/qh-chung/hung-yen/huyen-van-giang--40c-do-thi/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/hung-yen-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "haiduong": GulandProvinceInfo(
            id: "haiduong",
            name: "Hải Dương",
            slug: "hai-duong",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hai-duong-2030-dc/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/hai-duong/thanh-pho-hai-duong/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/hai-duong/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hai-duong-2030-dc/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hai-duong--qhc3/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/500 - 1/2000", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hai-phong--qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/hai-duong--qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-han02.fptcloud.com/guland/hai-duong-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/hai-duong/thanh-pho-hai-duong/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-han02.fptcloud.com/guland/hai-duong-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "vinhphuc": GulandProvinceInfo(
            id: "vinhphuc",
            name: "Vĩnh Phúc",
            slug: "vinh-phuc",
            qh2030: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/vinh-phuc-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/vinh-phuc/thanh-pho-vinh-yen/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/vinh-phuc/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/vinh-phuc-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/vinh-phuc--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/vinh-phuc/thanh-pho-vinh-yen/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/vinh-phuc-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "hanam": GulandProvinceInfo(
            id: "hanam",
            name: "Hà Nam",
            slug: "ha-nam",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/ha-nam-2030-dc/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ha-nam/thanh-pho-phu-ly--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/ha-nam/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/ha-nam-2030-dc/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/ha-nam/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ha-nam/thanh-pho-phu-ly--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/ha-nam-2030-dc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "namdinh": GulandProvinceInfo(
            id: "namdinh",
            name: "Nam Định",
            slug: "nam-dinh",
            qh2030: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/nam-dinh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/nam-dinh/thanh-pho-nam-dinh/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/nam-dinh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/nam-dinh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/nam-dinh--qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-xd/nam-dinh/thanh-pho-nam-dinh--qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/nam-dinh/thanh-pho-nam-dinh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/nam-dinh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "ninhbinh": GulandProvinceInfo(
            id: "ninhbinh",
            name: "Ninh Bình",
            slug: "ninh-binh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/ninh-binh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ninh-binh/thanh-pho-hoa-lu/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/ninh-binh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ninh-binh/thanh-pho-hoa-lu/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/ninh-binh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "thaibinh": GulandProvinceInfo(
            id: "thaibinh",
            name: "Thái Bình",
            slug: "thai-binh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-binh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/thai-binh/thanh-pho-thai-binh--25dc/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/thai-binh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-binh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/thai-binh/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/thaibinh-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/thai-binh/thanh-pho-thai-binh--25dc/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/thaibinh-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "thainguyen": GulandProvinceInfo(
            id: "thainguyen",
            name: "Thái Nguyên",
            slug: "thai-nguyen",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-nguyen-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/thai-nguyen/thanh-pho-thai-nguyen--bs/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/thai-nguyen/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-nguyen-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-khac/thai-nguyen/thanh-pho-thai-nguyen--qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/thai-nguyen/thanh-pho-thai-nguyen--bs/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/thai-nguyen-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "bacgiang": GulandProvinceInfo(
            id: "bacgiang",
            name: "Bắc Giang",
            slug: "bac-giang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/bac-giang-2030-2/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/bac-giang/thanh-pho-bac-giang/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/bac-giang/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/bac-giang-2030-2/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH chung", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/bac-giang--qhc/{z}/{x}/{y}.png?v=ok", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/bac-giang--qhcxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-han02.fptcloud.com/guland/bac-giang-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/bac-giang/thanh-pho-bac-giang/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-han02.fptcloud.com/guland/bac-giang-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "phutho": GulandProvinceInfo(
            id: "phutho",
            name: "Phú Thọ",
            slug: "phu-tho",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/phu-tho-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/phu-tho/thanh-pho-viet-tri/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/phu-tho-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/phu-tho/thanh-pho-viet-tri/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/phu-tho-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "langson": GulandProvinceInfo(
            id: "langson",
            name: "Lạng Sơn",
            slug: "lang-son",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/lang-son-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/lang-son/thanh-pho-lang-son--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/lang-son/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/lang-son-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/lang-son/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-han02.fptcloud.com/guland/lang-son-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/lang-son/thanh-pho-lang-son--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-han02.fptcloud.com/guland/lang-son-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "caobang": GulandProvinceInfo(
            id: "caobang",
            name: "Cao Bằng",
            slug: "cao-bang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/cao-bang-2030-dc/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland7/qh-2024/cao-bang/thanh-pho-cao-bang/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/cao-bang-2030-dc/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-xd/cao-bang/thanh-pho-cao-bang--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland7/qh-2024/cao-bang/thanh-pho-cao-bang/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/cao-bang-2030-dc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "backan": GulandProvinceInfo(
            id: "backan",
            name: "Bắc Kạn",
            slug: "bac-kan",
            qh2030: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/bac-kan-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/bac-kan/thanh-pho-bac-kan/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/bac-kan/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/bac-kan-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/bac-kan--qhpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/bac-kan/thanh-pho-bac-kan/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland4/qh/bac-kan-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "tuyenquang": GulandProvinceInfo(
            id: "tuyenquang",
            name: "Tuyên Quang",
            slug: "tuyen-quang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/tuyen-quang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2021/tuyen-quang/thanh-pho-tuyen-quang/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/tuyen-quang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2021/tuyen-quang/thanh-pho-tuyen-quang/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/tuyen-quang-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "hagiang": GulandProvinceInfo(
            id: "hagiang",
            name: "Hà Giang",
            slug: "ha-giang",
            qh2030: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/ha-giang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ha-giang/thanh-pho-ha-giang/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/ha-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ha-giang/thanh-pho-ha-giang/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://guland.sgp1.cdn.digitaloceanspaces.com/qh/ha-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "laocai": GulandProvinceInfo(
            id: "laocai",
            name: "Lào Cai",
            slug: "lao-cai",
            qh2030: "https://guland2.sgp1.cdn.digitaloceanspaces.com/qh/lao-cai-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland5/qh-2024/lao-cai/thanh-pho-lao-cai/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://guland2.sgp1.cdn.digitaloceanspaces.com/qh/lao-cai-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland5/qh-2024/lao-cai/thanh-pho-lao-cai/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://guland2.sgp1.cdn.digitaloceanspaces.com/qh/lao-cai-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "yenbai": GulandProvinceInfo(
            id: "yenbai",
            name: "Yên Bái",
            slug: "yen-bai",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/yen-bai-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/yen-bai/thanh-pho-yen-bai/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/yen-bai-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/yen-bai/thanh-pho-yen-bai/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/yen-bai-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "hoabinh": GulandProvinceInfo(
            id: "hoabinh",
            name: "Hòa Bình",
            slug: "hoa-binh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/hoa-binh-2030-2/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/hoa-binh/thanh-pho-hoa-binh/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/hoa-binh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/hoa-binh-2030-2/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/hoa-binh/thanh-pho-hoa-binh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/hoa-binh-2030-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "sonla": GulandProvinceInfo(
            id: "sonla",
            name: "Sơn La",
            slug: "son-la",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/son-la-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/son-la/thanh-pho-son-la/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/son-la-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/son-la-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-xd/son-la/tp-son-la--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/son-la/thanh-pho-son-la/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/son-la-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "dienbien": GulandProvinceInfo(
            id: "dienbien",
            name: "Điện Biên",
            slug: "dien-bien",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/dien-bien-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland5/qh-2024/dien-bien/thanh-pho-dien-bien-phu/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/dien-bien-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland5/qh-2024/dien-bien/thanh-pho-dien-bien-phu/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/dien-bien-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "laichau": GulandProvinceInfo(
            id: "laichau",
            name: "Lai Châu",
            slug: "lai-chau",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/lai-chau-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/lai-chau/thanh-pho-lai-chau/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/lai-chau-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/lai-chau/thanh-pho-lai-chau/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/lai-chau-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "thanhhoa": GulandProvinceInfo(
            id: "thanhhoa",
            name: "Thanh Hóa",
            slug: "thanh-hoa",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/thanh-hoa-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/thanh-hoa/thanh-pho-thanh-hoa/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/thanh-hoa/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/thanh-hoa-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/thanh-hoa/tp-thanh-hoa--qhpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/thanh-hoa/thanh-pho-thanh-hoa/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/thanh-hoa-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "nghean": GulandProvinceInfo(
            id: "nghean",
            name: "Nghệ An",
            slug: "nghe-an",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/nghe-an-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/nghe-an/huyen-quy-chau/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/nghe-an/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/nghe-an-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/nghe-an/vinh--qhxdpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/nghe-an/huyen-quy-chau/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/nghe-an-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "hatinh": GulandProvinceInfo(
            id: "hatinh",
            name: "Hà Tĩnh",
            slug: "ha-tinh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/ha-tinh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ha-tinh/thanh-pho-ha-tinh/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/ha-tinh-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/ha-tinh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/ha-tinh--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ha-tinh/thanh-pho-ha-tinh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/ha-tinh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "quangbinh": GulandProvinceInfo(
            id: "quangbinh",
            name: "Quảng Bình",
            slug: "quang-binh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/quang-binh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/quang-binh/thanh-pho-dong-hoi/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/quang-binh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-binh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/quang-binh--qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/quang-binh/thanh-pho-dong-hoi/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-binh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "quangtri": GulandProvinceInfo(
            id: "quangtri",
            name: "Quảng Trị",
            slug: "quang-tri",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/quang-tri-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/quang-tri/thi-xa-quang-tri/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/quang-tri-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/quang-tri/thi-xa-quang-tri/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/quang-tri-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "thuathienhue": GulandProvinceInfo(
            id: "thuathienhue",
            name: "Thừa Thiên Huế",
            slug: "thua-thien-hue",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/thua-thien-hue-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/thua-thien-hue/thanh-pho-hue/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/hue/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/thua-thien-hue-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qhxd/hue/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/thua-thien-hue/thanh-pho-hue/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qhxd/hue/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qhxd/hue/{z}/{x}/{y}.png", typeCode: "layer_qhpk_qhxd"),
            ]
        ),
        "danang": GulandProvinceInfo(
            id: "danang",
            name: "Đà Nẵng",
            slug: "da-nang",
            qh2030: "https://sgp1.digitaloceanspaces.com/guland/qh/da-nang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland6/qh-2024/da-nang/quan-hai-chau/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/da-nang-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://sgp1.digitaloceanspaces.com/guland/qh/da-nang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/da-nang/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/500", url: "https://s3-han02.fptcloud.com/guland3/da-nang/1-500/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/2000", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/da-nang--qhpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/5000", url: "https://s3-han02.fptcloud.com/guland3/da-nang/1-5000/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/10000", url: "https://s3-han02.fptcloud.com/guland3/da-nang/1-10000/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/danang-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland6/qh-2024/da-nang/quan-hai-chau/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/danang-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "quangnam": GulandProvinceInfo(
            id: "quangnam",
            name: "Quảng Nam",
            slug: "quang-nam",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/quang-nam-2030/{z}/{x}/{y}.png",
            khHangNam: nil,
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/quang-nam-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/quang-nam-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "quangngai": GulandProvinceInfo(
            id: "quangngai",
            name: "Quảng Ngãi",
            slug: "quang-ngai",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/quang-ngai-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/quang-ngai/thanh-pho-quang-ngai--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/quang-ngai/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-ngai-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/quang-ngai/thanh-pho-quang-ngai--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/quang-ngai-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "binhdinh": GulandProvinceInfo(
            id: "binhdinh",
            name: "Bình Định",
            slug: "binh-dinh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/binh-dinh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/binh-dinh/thanh-pho-quy-nhon/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/binh-dinh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/binh-dinh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-xd/binh-dinh/quy-nhon--qhpkct/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/binh-dinh/thanh-pho-quy-nhon/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/binh-dinh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "phuyen": GulandProvinceInfo(
            id: "phuyen",
            name: "Phú Yên",
            slug: "phu-yen",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/phu-yen-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/phu-yen/thanh-pho-tuy-hoa/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/phu-yen/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/phu-yen-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/phu-yen/thanh-pho-tuy-hoa/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/phu-yen-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "khanhhoa": GulandProvinceInfo(
            id: "khanhhoa",
            name: "Khánh Hòa",
            slug: "khanh-hoa",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/khanh-hoa-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/khanh-hoa/thanh-pho-nha-trang--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/khanh-hoa/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/khanh-hoa-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH 2045", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2045/khanh-hoa-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/khanh-hoa/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qhpk/khanh-hoa-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/khanh-hoa/thanh-pho-nha-trang--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qhpk/khanh-hoa-2/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "ninhthuan": GulandProvinceInfo(
            id: "ninhthuan",
            name: "Ninh Thuận",
            slug: "ninh-thuan",
            qh2030: "https://251db3a9dce2de5.cmccloud.com.vn/guland6/qh/ninh-thuan-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ninh-thuan/thanh-pho-phan-rang-thap-cham--25/{z}/{x}/{y}.png",
            layerLand: nil,
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland6/qh/ninh-thuan-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ninh-thuan/thanh-pho-phan-rang-thap-cham--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://251db3a9dce2de5.cmccloud.com.vn/guland6/qh/ninh-thuan-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "binhthuan": GulandProvinceInfo(
            id: "binhthuan",
            name: "Bình Thuận",
            slug: "binh-thuan",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-thuan-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/binh-thuan/thanh-pho-phan-thiet/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/binh-thuan/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-thuan-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/binh-thuan/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/binh-thuan/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/binh-thuan/thanh-pho-phan-thiet/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/binh-thuan/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "kontum": GulandProvinceInfo(
            id: "kontum",
            name: "Kon Tum",
            slug: "kon-tum",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/kon-tum-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/kon-tum/thanh-pho-kon-tum--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/kon-tum/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/kon-tum-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/kon-tum/thanh-pho-kon-tum--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/kon-tum-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "gialai": GulandProvinceInfo(
            id: "gialai",
            name: "Gia Lai",
            slug: "gia-lai",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/gia-lai-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/gia-lai/thanh-pho-pleiku/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/gia-lai-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/gia-lai-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland5/qh-xd/gia-lai/pleiku--30qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/gia-lai/thanh-pho-pleiku/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/gia-lai-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "daklak": GulandProvinceInfo(
            id: "daklak",
            name: "Đắk Lắk",
            slug: "dak-lak",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/dak-lak-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/dak-lak/thanh-pho-buon-ma-thuot/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/daklak-2025/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/dak-lak-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/daklak--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/dak-lak/thanh-pho-buon-ma-thuot/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/dak-lak-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "daknong": GulandProvinceInfo(
            id: "daknong",
            name: "Đắk Nông",
            slug: "dak-nong",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/dak-nong-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/dak-nong/thanh-pho-gia-nghia--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/daknong/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/dak-nong-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/daklak--qhxdc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/dak-nong/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/dak-nong/thanh-pho-gia-nghia--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/dak-nong/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "lamdong": GulandProvinceInfo(
            id: "lamdong",
            name: "Lâm Đồng",
            slug: "lam-dong",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/lam-dong-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/lam-dong/thanh-pho-da-lat--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/lam-dong/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/lam-dong-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/lam-dong/thanh-pho-da-lat--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/lam-dong-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "hcm": GulandProvinceInfo(
            id: "hcm",
            name: "TP. Hồ Chí Minh",
            slug: "tp-ho-chi-minh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/tp-ho-chi-minh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/ho-chi-minh/quan-tan-binh/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/hcm/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland3/qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 1/500, 1/2000", url: "https://s3-han02.fptcloud.com/guland/hcm-qhxd3/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/tp-ho-chi-minh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "Metro", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/metro-hcm-3/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH chung 100 năm (Dự thảo)", url: "https://r4gmiynxmeobj.vcdn.cloud/hcm-100-nam/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/ho-chi-minh/quan-tan-binh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "binhduong": GulandProvinceInfo(
            id: "binhduong",
            name: "Bình Dương",
            slug: "binh-duong",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/binh-duong-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/binh-duong/thanh-pho-ben-cat--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/binh-duong/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/binh-duong-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/binh-duong/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/binh-duong/thanh-pho-ben-cat--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_qhxd"),
            ]
        ),
        "dongnai": GulandProvinceInfo(
            id: "dongnai",
            name: "Đồng Nai",
            slug: "dong-nai",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/dong-nai-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland9/qh-2025/dong-nai/thanh-pho-bien-hoa--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/dong-nai-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/dong-nai-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-xd/binh-phuoc--qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland9/qh-2025/dong-nai/thanh-pho-bien-hoa--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/dong-nai-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "bariavungtau": GulandProvinceInfo(
            id: "bariavungtau",
            name: "Bà Rịa - Vũng Tàu",
            slug: "ba-ria-vung-tau",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/ba-ria-vung-tau-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ba-ria-vung-tau/thi-xa-phu-my/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/baria-vungtau-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/ba-ria-vung-tau-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-han02.fptcloud.com/guland/brvt-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland10/qh-khac/ba-ria-vung-tau/thi-xa-phu-my--qhpk123456/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland9/qh-2025/ba-ria-vung-tau/thi-xa-phu-my/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland7/qh-chung/hcm-qhc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "binhphuoc": GulandProvinceInfo(
            id: "binhphuoc",
            name: "Bình Phước",
            slug: "binh-phuoc",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-phuoc-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/binh-phuoc/huyen-phu-rieng/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/binh-phuoc/{z}/{x}/{y}.png",
            maxNativeZoom: 16,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/binh-phuoc-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/binh-phuoc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/binh-phuoc/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/binh-phuoc/huyen-phu-rieng/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qhxd/binh-phuoc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "tayninh": GulandProvinceInfo(
            id: "tayninh",
            name: "Tây Ninh",
            slug: "tay-ninh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/tay-ninh-2030/{z}/{x}/{y}.png",
            khHangNam: nil,
            layerLand: "https://intercdn.guland.vn/land/tay-ninh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH phân khu", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/tay-ninh/tp-tay-ninh--qhxdpk/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/tay-ninh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "longan": GulandProvinceInfo(
            id: "longan",
            name: "Long An",
            slug: "long-an",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/long-an-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/long-an/thanh-pho-tan-an/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/long-an/{z}/{x}/{y}.png",
            maxNativeZoom: 19,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/long-an-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/long-an/thanh-pho-tan-an/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/long-an-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "tiengiang": GulandProvinceInfo(
            id: "tiengiang",
            name: "Tiền Giang",
            slug: "tien-giang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/tien-giang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/tien-giang/huyen-chau-thanh/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/tien-giang/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/tien-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/tien-giang/huyen-chau-thanh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/tien-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "bentre": GulandProvinceInfo(
            id: "bentre",
            name: "Bến Tre",
            slug: "ben-tre",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/ben-tre-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/ben-tre/thanh-pho-ben-tre/{z}/{x}/{y}.png",
            layerLand: "https://s3-hn-2.cloud.cmctelecom.vn/guland6/land/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/ben-tre-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/qh-2024/ben-tre/thanh-pho-ben-tre/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/ben-tre-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "travinh": GulandProvinceInfo(
            id: "travinh",
            name: "Trà Vinh",
            slug: "tra-vinh",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/tra-vinh-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/tra-vinh/thanh-pho-tra-vinh--25/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/tra-vinh/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/tra-vinh-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/tra-vinh/thanh-pho-tra-vinh--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/tra-vinh-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "vinhlong": GulandProvinceInfo(
            id: "vinhlong",
            name: "Vĩnh Long",
            slug: "vinh-long",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/vinh-long-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/vinh-long/thanh-pho-vinh-long/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/vinh-long/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/vinh-long-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/vinh-long/thanh-pho-vinh-long/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/vinh-long-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "dongthap": GulandProvinceInfo(
            id: "dongthap",
            name: "Đồng Tháp",
            slug: "dong-thap",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/dong-thap-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/dong-thap/thanh-pho-cao-lanh--25/{z}/{x}/{y}.png",
            layerLand: "https://s3-hn-2.cloud.cmctelecom.vn/guland7/land/dong-thap/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/dong-thap-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-han02.fptcloud.com/guland4/qh-xd/dong-thap/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/dong-thap/thanh-pho-cao-lanh--25/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/dong-thap-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "cantho": GulandProvinceInfo(
            id: "cantho",
            name: "Cần Thơ",
            slug: "can-tho",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/can-tho-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/can-tho/quan-binh-thuy/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/can-tho/{z}/{x}/{y}.png",
            maxNativeZoom: 16,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/can-tho-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3.hn-1.cloud.cmctelecom.vn/guland6/qh-xd/can-tho/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/can-tho/quan-binh-thuy/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/can-tho-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "angiang": GulandProvinceInfo(
            id: "angiang",
            name: "An Giang",
            slug: "an-giang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/v2/an-giang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/an-giang/thanh-pho-long-xuyen/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/an-giang/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/an-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland2/qh-2023/an-giang/thanh-pho-long-xuyen/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/v2/an-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "kiengiang": GulandProvinceInfo(
            id: "kiengiang",
            name: "Kiên Giang",
            slug: "kien-giang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/kien-giang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/kien-giang/thanh-pho-rach-gia/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/kien-giang/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/kien-giang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH phân khu", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/phuquoc-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/kien-giang/thanh-pho-rach-gia/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland4/phuquoc-qhxd/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "haugiang": GulandProvinceInfo(
            id: "haugiang",
            name: "Hậu Giang",
            slug: "hau-giang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hau-giang-2030--dc/{z}/{x}/{y}.png",
            khHangNam: "https://s3-han02.fptcloud.com/guland8/qh-2025/hau-giang/thanh-pho-vi-thanh/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/hau-giang/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hau-giang-2030--dc/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "QH xây dựng", url: "https://s3-han02.fptcloud.com/guland5/qhxd/hau-giang/{z}/{x}/{y}.png", typeCode: "layer_qhpk_2"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-han02.fptcloud.com/guland8/qh-2025/hau-giang/thanh-pho-vi-thanh/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/new_24092024/hau-giang-2030--dc/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "soctrang": GulandProvinceInfo(
            id: "soctrang",
            name: "Sóc Trăng",
            slug: "soc-trang",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/soc-trang-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/soc-trang/thanh-pho-soc-trang/{z}/{x}/{y}.png",
            layerLand: "https://s3-han02.fptcloud.com/guland6/land/soc-trang-2/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/soc-trang-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/soc-trang/thanh-pho-soc-trang/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/soc-trang-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "baclieu": GulandProvinceInfo(
            id: "baclieu",
            name: "Bạc Liêu",
            slug: "bac-lieu",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/bac-lieu-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland3/qh-2024/bac-lieu/thanh-pho-bac-lieu/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/bac-lieu/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/bac-lieu-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland3/qh-2024/bac-lieu/thanh-pho-bac-lieu/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/bac-lieu-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
        "camau": GulandProvinceInfo(
            id: "camau",
            name: "Cà Mau",
            slug: "ca-mau",
            qh2030: "https://r4gmiynxmeobj.vcdn.cloud/ca-mau-2030/{z}/{x}/{y}.png",
            khHangNam: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ca-mau/thanh-pho-ca-mau/{z}/{x}/{y}.png",
            layerLand: "https://intercdn.guland.vn/land/ca-mau/{z}/{x}/{y}.png",
            maxNativeZoom: 18,
            extraLayers: [
                GulandExtraLayer(label: "QH 2030", url: "https://r4gmiynxmeobj.vcdn.cloud/ca-mau-2030/{z}/{x}/{y}.png", typeCode: "layer_1"),
                GulandExtraLayer(label: "KH 2026", url: "https://s3-hn-2.cloud.cmctelecom.vn/guland8/qh-2025/ca-mau/thanh-pho-ca-mau/{z}/{x}/{y}.png", typeCode: "layer_2022"),
                GulandExtraLayer(label: "QH khác", url: "https://r4gmiynxmeobj.vcdn.cloud/ca-mau-2030/{z}/{x}/{y}.png", typeCode: "layer_qhpk"),
            ]
        ),
    ]

    static func getProvinceInfo(_ provinceId: String) -> GulandProvinceInfo? {
        if let direct = provincesData[provinceId] {
            return direct
        }
        let cleanId = provinceId.replacingOccurrences(of: "-", with: "").lowercased()
        if let matched = provincesData.first(where: { $0.key.replacingOccurrences(of: "-", with: "").lowercased() == cleanId }) {
            return matched.value
        }
        return nil
    }
}

