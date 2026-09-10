import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var isShowingSearchHistory: Bool = false

    var body: some View {
        ZStack {
            // 1. Bản đồ GIS Lớp Phủ Toàn Màn Hình (MapLibre GL Engine)
            PlanningMapView(viewModel: viewModel)
                .ignoresSafeArea()

            // 2. Thanh Điều Khiển Nổi Phía Trên (Header + Chọn Tỉnh + Search + Layer Bar)
            if !viewModel.isFullScreenMode {
                VStack(spacing: 8) {
                    // Header Bar
                    HStack(spacing: 12) {
                        HStack(spacing: 10) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Circle())
                                .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)

                            VStack(alignment: .leading, spacing: 1) {
                                Text("Quy Hoạch Bản Đồ")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.primary)
                                Text("63 Tỉnh Thành Toàn Quốc")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                            }
                        }

                        Spacer()

                        // Quick Province Picker Chip
                        Button(action: { viewModel.isShowingProvincePicker = true }) {
                            HStack(spacing: 6) {
                                Text(viewModel.selectedProvince.name)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(Color.blue.opacity(0.12))
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)

                    // Search Bar Thửa đất / Tọa độ / Địa chỉ
                    VStack(spacing: 0) {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Tìm tỉnh, tọa độ GPS hoặc số tờ/số thửa...", text: $viewModel.searchQuery)
                                .font(.system(size: 14))
                                .onSubmit {
                                    viewModel.performSearch()
                                    isShowingSearchHistory = false
                                }

                            if !viewModel.searchQuery.isEmpty {
                                Button(action: { viewModel.searchQuery = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }

                            Button(action: {
                                viewModel.performSearch()
                                isShowingSearchHistory = false
                            }) {
                                Text("Tìm")
                                    .font(.system(size: 13, weight: .bold))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 9)

                        // Gợi ý lịch sử tìm kiếm gần đây
                        if isShowingSearchHistory && !viewModel.searchHistory.isEmpty {
                            Divider()
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Lịch sử tìm kiếm gần đây")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 14)
                                    .padding(.top, 6)

                                ForEach(viewModel.searchHistory.prefix(4), id: \.self) { hist in
                                    Button(action: {
                                        viewModel.searchQuery = hist
                                        viewModel.performSearch()
                                        isShowingSearchHistory = false
                                    }) {
                                        HStack {
                                            Image(systemName: "clock.arrow.circlepath")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                            Text(hist)
                                                .font(.system(size: 13))
                                                .foregroundColor(.primary)
                                            Spacer()
                                        }
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                    .onTapGesture {
                        isShowingSearchHistory.toggle()
                    }

                    // Thanh chọn Layer quy hoạch đa dạng
                    if !viewModel.availableLayers.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(viewModel.availableLayers) { layer in
                                    let isSelected = layer.id == viewModel.activeLayer?.id
                                    Button(action: { viewModel.selectLayer(layer) }) {
                                        HStack(spacing: 6) {
                                            Circle()
                                                .fill(Color(hex: layer.colorHex))
                                                .frame(width: 8, height: 8)

                                            Text(layer.label)
                                                .font(.system(size: 12, weight: isSelected ? .bold : .medium))
                                                .foregroundColor(isSelected ? .white : .primary)

                                            if layer.isVector {
                                                Text("MVT")
                                                    .font(.system(size: 9, weight: .bold))
                                                    .padding(.horizontal, 4)
                                                    .padding(.vertical, 1)
                                                    .background(isSelected ? Color.white.opacity(0.3) : Color.green.opacity(0.15))
                                                    .foregroundColor(isSelected ? .white : .green)
                                                    .cornerRadius(4)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 7)
                                        .background(isSelected ? Color.blue : Color(.systemBackground).opacity(0.9))
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(isSelected ? 0.15 : 0.04), radius: 3, x: 0, y: 1)
                                    }
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                }
                .padding(.top, 54)
                .padding(.horizontal, 14)
                .frame(maxHeight: .infinity, alignment: .top)
            }

            // 3. Banner Hiển Thị Đo Đạc Thực Địa (Nếu đang bật thước đo)
            if viewModel.measureMode != .none {
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: viewModel.measureMode == .distance ? "ruler" : "square.dashed")
                            .foregroundColor(.white)
                        Text(viewModel.measureMode == .distance ? "Đo khoảng cách thực địa" : "Đo diện tích đa giác")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: { viewModel.setMeasureMode(.none) }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.system(size: 18))
                        }
                    }

                    HStack {
                        if viewModel.measureMode == .distance {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Tổng khoảng cách:")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.8))
                                let dist = viewModel.measuredDistanceMeters
                                Text(dist >= 1000 ? "\(String(format: "%.2f", dist / 1000)) km" : "\(String(format: "%.1f", dist)) m")
                                    .font(.system(size: 18, weight: .heavy))
                                    .foregroundColor(.white)
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Tổng diện tích:")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.8))
                                let area = viewModel.measuredAreaSquareMeters
                                Text(area >= 10000 ? "\(String(format: "%.2f", area / 10000)) ha (\(String(format: "%.0f", area)) m²)" : "\(String(format: "%.1f", area)) m²")
                                    .font(.system(size: 18, weight: .heavy))
                                    .foregroundColor(.white)
                            }
                        }

                        Spacer()

                        Text("Chạm bản đồ để cắm mốc (\(viewModel.measuredPointsCount) điểm)")
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.8))
                    }

                    HStack(spacing: 10) {
                        Button(action: { viewModel.clearMeasurement() }) {
                            Text("Xóa mốc đo")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }

                        Spacer()

                        Button(action: { viewModel.setMeasureMode(.none) }) {
                            Text("Hoàn tất đo")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(14)
                .background(Color.blue)
                .cornerRadius(16)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 14)
                .padding(.top, viewModel.isFullScreenMode ? 54 : 180)
                .frame(maxHeight: .infinity, alignment: .top)
            }

            // 4. Các Nút Tiện Ích Bản Đồ Nổi Bên Phải (Floating Action Buttons)
            VStack(spacing: 10) {
                // Nút Toàn Màn Hình
                Button(action: { viewModel.isFullScreenMode.toggle() }) {
                    FABIcon(icon: viewModel.isFullScreenMode ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                }

                // Nút Chuyển Đổi Bản Đồ Nền
                Button(action: { viewModel.isShowingBaseMapPicker = true }) {
                    FABIcon(icon: "square.3.layers.3d.down.right.fill", color: .indigo)
                }

                // Nút Chuyển Đổi Tọa Độ VN-2000 (Sổ Đỏ)
                Button(action: { viewModel.isShowingVN2000Sheet = true }) {
                    FABIcon(icon: "square.grid.3x3.fill", color: .orange)
                }

                // Menu Thước Đo Thực Địa
                Menu {
                    Button(action: { viewModel.setMeasureMode(.distance) }) {
                        Label("Đo khoảng cách (m / km)", systemImage: "ruler")
                    }
                    Button(action: { viewModel.setMeasureMode(.area) }) {
                        Label("Đo diện tích đa giác (m² / ha)", systemImage: "square.dashed")
                    }
                    if viewModel.measureMode != .none {
                        Button(role: .destructive, action: { viewModel.setMeasureMode(.none) }) {
                            Label("Tắt chế độ đo", systemImage: "xmark")
                        }
                    }
                } label: {
                    FABIcon(icon: "ruler.fill", color: viewModel.measureMode != .none ? .red : .teal)
                }

                // Nút Thửa Đất Đã Lưu (Bookmarks)
                Button(action: { viewModel.isShowingBookmarksSheet = true }) {
                    ZStack {
                        FABIcon(icon: "bookmark.fill", color: .yellow)
                        if !viewModel.savedParcels.isEmpty {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .offset(x: 12, y: -12)
                        }
                    }
                }

                // GPS Button
                Button(action: { viewModel.requestUserLocation() }) {
                    FABIcon(icon: viewModel.isLocating ? "location.fill" : "location", color: .blue)
                }

                // Reset Camera về trung tâm tỉnh
                Button(action: { viewModel.selectProvince(viewModel.selectedProvince) }) {
                    FABIcon(icon: "arrow.counterclockwise", color: .blue)
                }
            }
            .padding(.trailing, 14)
            .padding(.bottom, viewModel.isFullScreenMode ? 100 : 220)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            // 5. Bảng Điều Khiển Độ Mờ Đục Dưới Cùng (Có 4 Preset Chuẩn Web)
            if !viewModel.isFullScreenMode {
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                        Text("Độ mờ đục bản đồ quy hoạch")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(Int(viewModel.opacityValue * 100))%")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.blue)
                    }

                    Slider(value: $viewModel.opacityValue, in: 0.0...1.0, step: 0.05)
                        .accentColor(.blue)

                    // 4 nút Preset nhanh như bản Web & Android
                    HStack(spacing: 6) {
                        let presets: [(Double, String)] = [
                            (0.0, "0% (Vệ tinh)"),
                            (0.5, "50%"),
                            (0.75, "75%"),
                            (1.0, "100%")
                        ]
                        ForEach(presets, id: \.0) { val, label in
                            let isPreset = abs(viewModel.opacityValue - val) < 0.03
                            Button(action: { viewModel.setOpacity(val) }) {
                                Text(label)
                                    .font(.system(size: 11, weight: isPreset ? .bold : .medium))
                                    .foregroundColor(isPreset ? .white : .primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 6)
                                    .background(isPreset ? Color.blue : Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                    }

                    HStack(spacing: 10) {
                        Button(action: { viewModel.isShowingLegendSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "paintpalette.fill")
                                Text("Chú giải màu đất")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        Button(action: {
                            viewModel.setOpacity(viewModel.opacityValue > 0.1 ? 0.0 : 0.75)
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: viewModel.opacityValue > 0.1 ? "eye.slash.fill" : "eye.fill")
                                Text(viewModel.opacityValue > 0.1 ? "Ẩn quy hoạch" : "Hiện quy hoạch")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(Color(.systemGray5))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(14)
                .background(.ultraThinMaterial)
                .cornerRadius(18)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 14)
                .padding(.bottom, 24)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .sheet(isPresented: $viewModel.isShowingProvincePicker) {
            ProvincePickerSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.isShowingLegendSheet) {
            LegendSheet(landTypes: viewModel.repository.landTypes)
        }
        .sheet(isPresented: $viewModel.isShowingVN2000Sheet) {
            VN2000ConverterSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.isShowingBookmarksSheet) {
            BookmarksSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.isShowingBaseMapPicker) {
            BaseMapPickerSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.isShowingParcelDetail) {
            if let parcel = viewModel.inspectedParcel {
                ParcelDetailSheet(parcel: parcel, onBookmarkToggle: { updated in
                    viewModel.toggleBookmark(updated)
                })
            }
        }
        .onOpenURL { url in
            viewModel.handleDeepLink(url)
        }
    }
}

struct FABIcon: View {
    let icon: String
    var color: Color = .primary

    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 44, height: 44)
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)

            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(color)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8 * 17), (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
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
