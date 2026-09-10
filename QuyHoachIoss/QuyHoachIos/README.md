# Quy Hoạch Bản Đồ 63 Tỉnh Thành - iOS Native App (SwiftUI)

Ứng dụng iOS Native độc lập tra cứu quy hoạch đất đai toàn bộ **63 Tỉnh/Thành phố Việt Nam** theo tiêu chuẩn [Guland.vn](https://guland.vn/) & [QuyHoach Web](https://quyhoach.app/), được xây dựng hoàn toàn bằng **Swift 5 & SwiftUI** hiện đại, đồng bộ 100% tính năng và vượt trội hơn so với bản Android và Web.

---

## 🚀 Điểm Nổi Bật & Tính Năng Nâng Cấp Chuẩn Web / Android

1. **Công Cụ Chuyển Đổi Tọa Độ VN-2000 ⇄ WGS84 & Vẽ Ranh Giới Thửa Đất**:
   - Tích hợp giải thuật toán học phép chiếu Gauss-Krüger / Transverse Mercator và **7 tham số chuyển đổi Helmert** theo Quyết định số 05/2007/QĐ-BTNMT.
   - Hỗ trợ nhập tọa độ X, Y trên sổ đỏ của 63 tỉnh thành theo kinh tuyến trục chuẩn (Múi 3° & 6°).
   - Dán danh sách tọa độ các đỉnh (Đỉnh 1, 2, 3, 4...) để tự động tính diện tích, chu vi và **vẽ đa giác ranh giới thửa đất phát sáng trực tiếp trên bản đồ vệ tinh**.

2. **Thước Đo Khoảng Cách & Diện Tích Thực Địa Thông Minh**:
   - **Đo khoảng cách**: Chạm các điểm trên bản đồ để nối tuyến đo, hiển thị tổng chiều dài (m / km).
   - **Đo diện tích**: Chạm các góc thửa đất để đo diện tích đa giác thực tế (m² / ha / sào).
   - Banner HUD tương tác mượt mà, hỗ trợ xóa điểm hoặc hoàn tất đo.

3. **Bộ Chọn 4 Kiểu Bản Đồ Nền Linh Hoạt**:
   - 🌍 **Vệ tinh kết hợp (Hybrid)**: Ảnh vệ tinh Google độ nét cao kèm tên đường & địa danh.
   - 🛰️ **Vệ tinh sạch (Satellite)**: Ảnh chụp vệ tinh nguyên bản, chi tiết cây cối nhà cửa.
   - 🗺️ **Bản đồ giao thông (Streets)**: Bản đồ đường bộ, số nhà và địa điểm.
   - 🏔️ **Bản đồ địa hình (Terrain)**: Bản đồ đường đồng mức và độ cao địa hình.

4. **Hệ Thống Layer Quy Hoạch Đa Dạng Cho 63 Tỉnh Thành**:
   - Cung cấp hàng chục lớp bản đồ cho các tỉnh trọng điểm (Hà Nội, TP.HCM, Đà Nẵng, Bình Dương, Đồng Nai, Bà Rịa - Vũng Tàu, Quảng Ninh, Khánh Hòa, Hải Phòng, Lâm Đồng...):
     + Quy hoạch sử dụng đất 2030 (QH 2030).
     + Vector MVT Protobuf (QHC 100 năm & Phân khu QHPK).
     + Kế hoạch sử dụng đất hàng năm.
     + Quy hoạch phân khu 1/2000 - 1/500, Quy hoạch sân bay Long Thành, TP. Thủ Đức, Vành đai 3 & 4...
     + Bản đồ địa chính, Quy hoạch giao thông, Phân khu Metro, Sông Hồng.
   - Điều khiển độ mờ đục Opacity từ **0% đến 100%** với **4 nút Preset nhanh (0%, 50%, 75%, 100%)**.

5. **Quản Lý Thửa Đất Đã Lưu (Bookmarks) & Lịch Sử Tra Cứu**:
   - Lưu lại các thửa đất yêu thích kèm ghi chú cá nhân (đơn giá, liên hệ chủ đất, vị trí mặt tiền).
   - Lịch sử tìm kiếm gần đây với gợi ý tìm kiếm thông minh.

6. **Bảng Chú Giải 30+ Mã Màu Đất & Cẩm Nang Luật Đất Đai 2024**:
   - Tra cứu đầy đủ các mã: **ODT, ONT, TMD, SKC, SKK, SKX, CLN, BHK, LUC, LUK, NTS, LMU, RSX, RPH, RDD, DGT, DNL, DTT, DKV, DYT, DGD, CGS...**
   - Đính kèm quy định cho phép/hạn chế chuyển đổi mục đích sang đất ở và trích dẫn điều luật.

7. **Chi Tiết Thửa Đất Nâng Cao & Dẫn Đường**:
   - Hiển thị cả tọa độ GPS (WGS84) và VN-2000 (X, Y).
   - Ước tính giá trị thị trường, mật độ xây dựng (80%-90%) và tầng cao tối đa.
   - Dẫn đường trực tiếp qua **Apple Maps** và **Google Maps**.
   - Chế độ **Toàn màn hình (Fullscreen)** mở rộng không gian quan sát bản đồ.

---

## 🛠️ Cấu Trúc Mã Nguồn Sau Khi Nâng Cấp

```
QuyHoachIos/
├── QuyHoachIos.xcodeproj/             # Cấu hình project Xcode hoàn chỉnh
├── QuyHoachIos/
│   ├── App/
│   │   └── QuyHoachIosApp.swift        # Điểm khởi chạy ứng dụng SwiftUI (@main)
│   ├── Models/
│   │   ├── Province.swift              # Dữ liệu Tỉnh/Thành & Kinh tuyến trục VN-2000
│   │   ├── LandType.swift              # 30+ Mã loại đất & Pháp lý Luật Đất Đai 2024
│   │   ├── Parcel.swift                # Cấu trúc Thửa đất, VN2000, Mật độ xây dựng, Bookmark
│   │   └── VN2000Point.swift           # Model điểm và đa giác ranh giới VN-2000
│   ├── Data/
│   │   ├── ProvinceRepository.swift    # 63 tỉnh thành & Bộ sưu tập Layer quy hoạch
│   │   └── VN2000Converter.swift       # Giải thuật chuyển đổi VN-2000 ⇄ WGS84 chuẩn Bộ TN&MT
│   ├── ViewModels/
│   │   └── MapViewModel.swift          # State management MVVM, Đo đạc, Bookmark, Base Maps
│   ├── Views/
│   │   ├── HomeScreen.swift            # Giao diện chính, Floating Bar, Thước đo, Layer Bar
│   │   ├── PlanningMapView.swift       # MapLibre GL Bridge, Thước đo, Base Maps, Polygon VN2000
│   │   ├── ProvincePickerSheet.swift   # Modal chọn 63 tỉnh theo miền & Kinh tuyến trục
│   │   ├── LegendSheet.swift           # Modal 30+ mã màu đất & Điều kiện chuyển đổi
│   │   ├── ParcelDetailSheet.swift     # Sheet xem chi tiết thửa đất, VN2000, Apple/Google Maps
│   │   ├── VN2000ConverterSheet.swift  # Công cụ chuyển đổi VN-2000 & Vẽ ranh giới sổ đỏ
│   │   ├── BookmarksSheet.swift        # Quản lý danh sách thửa đất đã lưu & ghi chú
│   │   └── BaseMapPickerSheet.swift    # Modal chọn 4 kiểu bản đồ nền Google
│   └── Resources/
│       ├── Info.plist                  # Quyền vị trí & Network Security
│       └── Assets.xcassets/            # AppIcon & Bảng màu hệ thống
├── .github/workflows/
│   └── ios-build.yml                   # CI/CD tự động build file zip cho Appetize.io
├── QuyHoach_API_Postman_Collection.json # Postman API Collection
├── QuyHoach_Postman_Environment.json   # Postman Environment
└── README.md                           # Tài liệu hướng dẫn
```

---

## 📱 Hướng Dẫn Chạy & Thử Nghiệm

### Cách 1: Mở trực tiếp trên máy Mac với Xcode
1. Mở thư mục `QuyHoachIos`.
2. Mở file `QuyHoachIos.xcodeproj` trong Xcode.
3. Chọn Simulator (ví dụ: **iPhone 15 Pro** hoặc **iPhone 16**).
4. Nhấn **Cmd + R** để chạy ứng dụng!

---

### Cách 2: Test trên Trình Duyệt Web qua Appetize.io (Dành cho máy Windows)
1. **Tải file Simulator `.app.zip`**:
   - Khi commit/push lên GitHub, GitHub Actions sẽ tự động biên dịch file `QuyHoachIos-Simulator.zip`.
2. **Kéo thả lên Appetize.io**:
   - Truy cập **[https://appetize.io/upload](https://appetize.io/upload)** và tải file `.zip` lên để trải nghiệm app iOS trực tiếp trên trình duyệt.
