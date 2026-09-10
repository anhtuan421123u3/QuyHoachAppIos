import SwiftUI
import CoreLocation

struct VN2000ConverterSheet: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss

    @State private var selectedProvince: Province
    @State private var use3DegreeZone: Bool = true
    @State private var selectedTab: Int = 0 // 0: 1 điểm, 1: Nhiều điểm (Đa giác sổ đỏ)

    // Mode 1: Single Point
    @State private var inputX: String = "2325500.5"
    @State private var inputY: String = "588200.2"
    @State private var convertedCoordinate: CLLocationCoordinate2D? = nil

    // Mode 2: Multi-point Polygon
    @State private var multiPointText: String = """
    1  2325500.50  588200.20
    2  2325520.80  588235.40
    3  2325490.20  588250.60
    4  2325470.00  588215.10
    """
    @State private var parsedPoints: [VN2000Point] = []
    @State private var polygonResult: VN2000PolygonResult? = nil

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        _selectedProvince = State(initialValue: viewModel.selectedProvince)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Segment Tab
                Picker("Chế độ", selection: $selectedTab) {
                    Text("1 Điểm Tọa Độ").tag(0)
                    Text("Đa Giác Sổ Đỏ (Nhiều Điểm)").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Section: Chọn Tỉnh & Kinh Tuyến Trục
                        VStack(alignment: .leading, spacing: 10) {
                            Text("THIẾT LẬP HỆ QUY CHIẾU VN-2000")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.secondary)

                            HStack {
                                Menu {
                                    ForEach(viewModel.repository.provinces) { prov in
                                        Button(action: {
                                            selectedProvince = prov
                                            recalculate()
                                        }) {
                                            HStack {
                                                Text(prov.name)
                                                Spacer()
                                                Text("(\(String(format: "%.2f", prov.centralMeridian))°)")
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                            .foregroundColor(.blue)
                                        Text(selectedProvince.name)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.system(size: 11))
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                            }

                            HStack(spacing: 12) {
                                HStack {
                                    Text("Kinh tuyến trục:")
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                    Text("\(String(format: "%.2f", selectedProvince.centralMeridian))°")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.blue)
                                }

                                Spacer()

                                Toggle("Múi 3° (Sổ đỏ)", isOn: $use3DegreeZone)
                                    .font(.system(size: 13, weight: .medium))
                                    .onChange(of: use3DegreeZone) { _ in recalculate() }
                            }
                            .padding(.horizontal, 4)
                        }
                        .padding(14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)

                        if selectedTab == 0 {
                            // MODE 1: SINGLE POINT LOOKUP
                            VStack(alignment: .leading, spacing: 12) {
                                Text("NHẬP TỌA ĐỘ TRÊN SỔ ĐỎ")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.secondary)

                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Tọa độ X (Bắc - m)")
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                        TextField("Ví dụ: 2325500.5", text: $inputX)
                                            .keyboardType(.numbersAndPunctuation)
                                            .padding(10)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Tọa độ Y (Đông - m)")
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                        TextField("Ví dụ: 588200.2", text: $inputY)
                                            .keyboardType(.numbersAndPunctuation)
                                            .padding(10)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }

                                // Preset mẫu
                                HStack(spacing: 6) {
                                    Text("Mẫu:")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)
                                    Button("Hà Nội") {
                                        selectedProvince = viewModel.repository.getProvince(by: "hanoi")
                                        inputX = "2325500.5"
                                        inputY = "588200.2"
                                        convertSinglePoint()
                                    }
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(6)

                                    Button("TP.HCM") {
                                        selectedProvince = viewModel.repository.getProvince(by: "hcm")
                                        inputX = "1194820.0"
                                        inputY = "605410.0"
                                        convertSinglePoint()
                                    }
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(6)

                                    Button("Đà Nẵng") {
                                        selectedProvince = viewModel.repository.getProvince(by: "danang")
                                        inputX = "1775200.0"
                                        inputY = "521400.0"
                                        convertSinglePoint()
                                    }
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(6)
                                }

                                Button(action: { convertSinglePoint() }) {
                                    HStack {
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                        Text("Chuyển đổi sang GPS (WGS84)")
                                    }
                                    .font(.system(size: 14, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }

                                if let coord = convertedCoordinate {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("KẾT QUẢ TỌA ĐỘ GPS WGS84")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.green)

                                        HStack {
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Vĩ độ (Latitude):")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.secondary)
                                                Text(String(format: "%.6f", coord.latitude))
                                                    .font(.system(size: 15, weight: .bold))
                                            }
                                            Spacer()
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Kinh độ (Longitude):")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.secondary)
                                                Text(String(format: "%.6f", coord.longitude))
                                                    .font(.system(size: 15, weight: .bold))
                                            }
                                        }

                                        Button(action: {
                                            viewModel.selectProvince(selectedProvince)
                                            viewModel.targetCoordinate = coord
                                            viewModel.inspectAtCoordinate(lat: coord.latitude, lng: coord.longitude)
                                            dismiss()
                                        }) {
                                            HStack {
                                                Image(systemName: "map.fill")
                                                Text("Xem vị trí trên bản đồ quy hoạch")
                                            }
                                            .font(.system(size: 14, weight: .bold))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(12)
                                }
                            }
                            .padding(14)
                            .background(.ultraThinMaterial)
                            .cornerRadius(14)
                        } else {
                            // MODE 2: MULTI-POINT POLYGON
                            VStack(alignment: .leading, spacing: 12) {
                                Text("DÁN DANH SÁCH TỌA ĐỘ CÁC ĐỈNH (BẢNG GÓC RANH SỔ ĐỎ)")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.secondary)

                                TextEditor(text: $multiPointText)
                                    .frame(height: 110)
                                    .font(.system(size: 13, design: .monospaced))
                                    .padding(6)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .onChange(of: multiPointText) { _ in parseMultiPoints() }

                                HStack(spacing: 8) {
                                    Button("Mẫu thửa đất 4 góc") {
                                        selectedProvince = viewModel.repository.getProvince(by: "hanoi")
                                        multiPointText = """
                                        1  2325500.50  588200.20
                                        2  2325530.80  588245.40
                                        3  2325495.20  588265.60
                                        4  2325465.00  588220.10
                                        """
                                        parseMultiPoints()
                                    }
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(6)

                                    Button("Xóa trắng") {
                                        multiPointText = ""
                                        parsedPoints = []
                                        polygonResult = nil
                                    }
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.red.opacity(0.1))
                                    .foregroundColor(.red)
                                    .cornerRadius(6)
                                }

                                if let poly = polygonResult {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("KẾT QUẢ TÍNH TOÁN RANH GIỚI THỬA ĐẤT")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.orange)

                                        HStack(spacing: 16) {
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Diện tích:")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.secondary)
                                                Text("\(String(format: "%.1f", poly.areaSquareMeters)) m²")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.primary)
                                            }

                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Chu vi:")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.secondary)
                                                Text("\(String(format: "%.1f", poly.perimeterMeters)) m")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.primary)
                                            }

                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Số đỉnh:")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.secondary)
                                                Text("\(poly.points.count) đỉnh")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.blue)
                                            }
                                        }

                                        // Danh sách các đỉnh
                                        ForEach(poly.points) { pt in
                                            HStack {
                                                Text("Đỉnh \(pt.order):")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.blue)
                                                    .frame(width: 50, alignment: .leading)
                                                Text("X: \(String(format: "%.1f", pt.x))  Y: \(String(format: "%.1f", pt.y))")
                                                    .font(.system(size: 12, design: .monospaced))
                                                Spacer()
                                            }
                                        }

                                        Button(action: {
                                            viewModel.selectProvince(selectedProvince)
                                            viewModel.applyVN2000Polygon(poly)
                                            dismiss()
                                        }) {
                                            HStack {
                                                Image(systemName: "viewfinder.circle.fill")
                                                Text("Vẽ ranh giới thửa đất lên bản đồ")
                                            }
                                            .font(.system(size: 14, weight: .bold))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(Color.orange)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.orange.opacity(0.12))
                                    .cornerRadius(12)
                                }
                            }
                            .padding(14)
                            .background(.ultraThinMaterial)
                            .cornerRadius(14)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Chuyển Đổi Tọa Độ VN-2000")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { dismiss() }
                }
            }
            .onAppear {
                convertSinglePoint()
                parseMultiPoints()
            }
        }
    }

    private func recalculate() {
        if selectedTab == 0 {
            convertSinglePoint()
        } else {
            parseMultiPoints()
        }
    }

    private func convertSinglePoint() {
        guard let x = Double(inputX), let y = Double(inputY) else { return }
        let coord = VN2000Converter.shared.vn2000ToWGS84(
            x: x,
            y: y,
            centralMeridian: selectedProvince.centralMeridian,
            zone3: use3DegreeZone
        )
        self.convertedCoordinate = coord
    }

    private func parseMultiPoints() {
        let pts = VN2000Converter.shared.parsePointsFromText(
            multiPointText,
            centralMeridian: selectedProvince.centralMeridian,
            zone3: use3DegreeZone
        )
        self.parsedPoints = pts
        self.polygonResult = VN2000Converter.shared.createPolygon(
            from: pts,
            provinceName: selectedProvince.name,
            centralMeridian: selectedProvince.centralMeridian
        )
    }
}
