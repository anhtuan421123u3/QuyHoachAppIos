import SwiftUI
import CoreLocation

// MARK: - HomeScreen - Dark Glassmorphism chuẩn Android/Web

struct HomeScreen: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var isShowingSearchHistory: Bool = false

    var body: some View {
        ZStack {
            // ── 0. Nền đen đồng bộ Dark Mode ──
            AppTheme.darkBg.ignoresSafeArea()

            // ── 1. Bản đồ GIS toàn màn hình ──
            PlanningMapView(viewModel: viewModel)
                .ignoresSafeArea()

            // ── 2. Scrim khi Drawer mở ──
            if viewModel.isDrawerOpen {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.closeDrawer() }
                    .transition(.opacity)
                    .zIndex(10)
            }

            // ── 3. Drawer Trượt Trái - Menu Điều Khiển Lớp ──
            if viewModel.isDrawerOpen {
                LayerControlDrawer(viewModel: viewModel, onClose: { viewModel.closeDrawer() })
                    .transition(.move(edge: .leading))
                    .zIndex(11)
            }

            // ── 3.5. Nút tab nổi '›' ở cạnh trái màn hình (chuẩn bản Web trên Mobile) ──
            if !viewModel.isDrawerOpen && !viewModel.isFullScreenMode {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.openDrawer()
                    }
                }) {
                    Text("›")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(AppTheme.greenAccent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 14)
                        .background(AppTheme.darkPanelBg)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(AppTheme.darkBorder, lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 2, y: 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.leading, 0)
                .zIndex(5)
            }

            // ── 4. Giao diện chính (ẩn khi Drawer mở + Fullscreen) ──
            if !viewModel.isFullScreenMode {
                VStack(spacing: 8) {

                    // ─── Header Bar Dark ───
                    HStack(spacing: 10) {
                        // Nút Hamburger mở Drawer
                        Button(action: { viewModel.toggleDrawer() }) {
                            VStack(spacing: 5) {
                                ForEach(0..<3, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(AppTheme.greenAccent)
                                        .frame(width: 20, height: 2)
                                }
                            }
                            .frame(width: 40, height: 36)
                            .background(AppTheme.darkItemBg)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AppTheme.darkBorder, lineWidth: 1)
                            )
                        }

                        // Logo + tiêu đề
                        VStack(alignment: .leading, spacing: 1) {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(AppTheme.greenGlow)
                                    .frame(width: 8, height: 8)
                                    .shadow(color: AppTheme.greenGlow.opacity(0.8), radius: 4)
                                Text("QuyHoachVietNam")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(AppTheme.textLight)
                            }
                            Text("63 Tỉnh Thành · \(viewModel.selectedProvince.name)")
                                .font(.system(size: 11))
                                .foregroundColor(AppTheme.textMuted)
                        }

                        Spacer()

                        // Chip tỉnh nhanh
                        Button(action: { viewModel.isShowingProvincePicker = true }) {
                            HStack(spacing: 5) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(AppTheme.greenAccent)
                                Text(viewModel.selectedProvince.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(AppTheme.greenAccent)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(AppTheme.greenAccent)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(AppTheme.greenAccent.opacity(0.12))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(AppTheme.greenAccent.opacity(0.4), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(AppTheme.darkPanelBg.opacity(0.92))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.darkBorder, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 4)

                    // ─── Search Bar Dark ───
                    VStack(spacing: 0) {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(AppTheme.textMuted)
                                .font(.system(size: 15))

                            TextField("", text: $viewModel.searchQuery)
                                .font(.system(size: 13))
                                .foregroundColor(AppTheme.textLight)
                                .placeholder(when: viewModel.searchQuery.isEmpty) {
                                    Text("Tìm tọa độ, địa chỉ, số tờ/thửa…")
                                        .font(.system(size: 13))
                                        .foregroundColor(AppTheme.textMuted.opacity(0.7))
                                }
                                .onSubmit {
                                    viewModel.performSearch()
                                    isShowingSearchHistory = false
                                }
                                .accentColor(AppTheme.greenAccent)

                            if !viewModel.searchQuery.isEmpty {
                                Button(action: { viewModel.searchQuery = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(AppTheme.textMuted)
                                }
                            }

                            Button(action: {
                                viewModel.performSearch()
                                isShowingSearchHistory = false
                            }) {
                                Text("Tìm")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(AppTheme.greenAccent)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 9)

                        // Gợi ý lịch sử
                        if isShowingSearchHistory && !viewModel.searchHistory.isEmpty {
                            Divider()
                                .background(AppTheme.darkBorder)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Tìm kiếm gần đây")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(AppTheme.textMuted)
                                    .padding(.horizontal, 14)
                                    .padding(.top, 8)
                                    .padding(.bottom, 4)

                                ForEach(viewModel.searchHistory.prefix(4), id: \.self) { hist in
                                    Button(action: {
                                        viewModel.searchQuery = hist
                                        viewModel.performSearch()
                                        isShowingSearchHistory = false
                                    }) {
                                        HStack(spacing: 8) {
                                            Image(systemName: "clock.arrow.circlepath")
                                                .font(.system(size: 11))
                                                .foregroundColor(AppTheme.textMuted)
                                            Text(hist)
                                                .font(.system(size: 13))
                                                .foregroundColor(AppTheme.textLight)
                                            Spacer()
                                        }
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 7)
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    .background(AppTheme.darkPanelBg.opacity(0.92))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(AppTheme.darkBorder, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.25), radius: 6, x: 0, y: 2)
                    .onTapGesture { isShowingSearchHistory.toggle() }

                    // ─── Layer Quick-Select Bar (ngang) ───
                    if !viewModel.availableLayers.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 7) {
                                ForEach(viewModel.availableLayers) { layer in
                                    let isSelected = layer.id == viewModel.activeLayer?.id
                                    Button(action: { viewModel.selectLayer(layer) }) {
                                        HStack(spacing: 5) {
                                            Circle()
                                                .fill(Color(hex: layer.colorHex))
                                                .frame(width: 7, height: 7)
                                            Text(layer.label)
                                                .font(.system(size: 11, weight: isSelected ? .bold : .medium))
                                                .foregroundColor(isSelected ? .black : AppTheme.textMuted)
                                                .lineLimit(1)
                                            if layer.isVector {
                                                Text("V")
                                                    .font(.system(size: 9, weight: .bold))
                                                    .foregroundColor(isSelected ? .black : AppTheme.greenAccent)
                                                    .padding(.horizontal, 3)
                                                    .background(isSelected ? Color.black.opacity(0.2) : AppTheme.greenAccent.opacity(0.18))
                                                    .cornerRadius(3)
                                            }
                                        }
                                        .padding(.horizontal, 9)
                                        .padding(.vertical, 6)
                                        .background(isSelected ? AppTheme.greenAccent : AppTheme.darkItemBg)
                                        .cornerRadius(9)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 9)
                                                .stroke(isSelected ? AppTheme.greenAccent : AppTheme.darkBorder, lineWidth: 1)
                                        )
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

            // ── 5. Banner Đo Đạc ──
            if viewModel.measureMode != .none {
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: viewModel.measureMode == .distance ? "ruler" : "square.dashed")
                            .foregroundColor(AppTheme.greenAccent)
                        Text(viewModel.measureMode == .distance ? "Đo khoảng cách thực địa" : "Đo diện tích đa giác")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(AppTheme.textLight)
                        Spacer()
                        Button(action: { viewModel.setMeasureMode(.none) }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(AppTheme.textMuted)
                                .font(.system(size: 18))
                        }
                    }
                    HStack {
                        if viewModel.measureMode == .distance {
                            let dist = viewModel.measuredDistanceMeters
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Tổng khoảng cách:")
                                    .font(.system(size: 11)).foregroundColor(AppTheme.textMuted)
                                Text(dist >= 1000 ? "\(String(format: "%.2f", dist / 1000)) km" : "\(String(format: "%.1f", dist)) m")
                                    .font(.system(size: 18, weight: .heavy)).foregroundColor(AppTheme.greenAccent)
                            }
                        } else {
                            let area = viewModel.measuredAreaSquareMeters
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Tổng diện tích:")
                                    .font(.system(size: 11)).foregroundColor(AppTheme.textMuted)
                                Text(area >= 10000 ? "\(String(format: "%.2f", area / 10000)) ha" : "\(String(format: "%.1f", area)) m²")
                                    .font(.system(size: 18, weight: .heavy)).foregroundColor(AppTheme.greenAccent)
                            }
                        }
                        Spacer()
                        Text("\(viewModel.measuredPointsCount) điểm đã cắm")
                            .font(.system(size: 11)).foregroundColor(AppTheme.textMuted)
                    }
                    HStack(spacing: 10) {
                        Button(action: { viewModel.clearMeasurement() }) {
                            Text("Xóa mốc").font(.system(size: 12, weight: .semibold))
                                .foregroundColor(AppTheme.textMuted)
                                .frame(maxWidth: .infinity).padding(.vertical, 7)
                                .background(AppTheme.darkItemBg).cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppTheme.darkBorder, lineWidth: 1))
                        }
                        Button(action: { viewModel.setMeasureMode(.none) }) {
                            Text("Hoàn tất").font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity).padding(.vertical, 7)
                                .background(AppTheme.greenAccent).cornerRadius(8)
                        }
                    }
                }
                .padding(14)
                .background(AppTheme.darkPanelBg)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppTheme.darkBorder, lineWidth: 1))
                .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 14)
                .padding(.top, viewModel.isFullScreenMode ? 54 : 200)
                .frame(maxHeight: .infinity, alignment: .top)
            }

            // ── 6. Floating Action Buttons Bên Phải (chuẩn Android) ──
            VStack(spacing: 9) {
                // Fullscreen toggle
                DarkFAB(icon: viewModel.isFullScreenMode ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right") {
                    viewModel.isFullScreenMode.toggle()
                }

                // Chuyển base map
                DarkFAB(icon: "square.3.layers.3d.down.right.fill", accentColor: AppTheme.blueAccent) {
                    viewModel.isShowingBaseMapPicker = true
                }

                // VN2000 sổ đỏ
                DarkFAB(icon: "square.grid.3x3.fill", accentColor: Color(hex: "#F59E0B")) {
                    viewModel.isShowingVN2000Sheet = true
                }

                // Thước đo
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
                    DarkFABView(icon: "ruler.fill", accentColor: viewModel.measureMode != .none ? AppTheme.redAccent : AppTheme.greenDim)
                }

                // Bookmarks
                ZStack {
                    DarkFAB(icon: "bookmark.fill", accentColor: Color(hex: "#FBBF24")) {
                        viewModel.isShowingBookmarksSheet = true
                    }
                    if !viewModel.savedParcels.isEmpty {
                        Circle().fill(AppTheme.redAccent).frame(width: 10, height: 10)
                            .offset(x: 12, y: -12)
                    }
                }

                // GPS
                DarkFAB(icon: viewModel.isLocating ? "location.fill" : "location",
                         accentColor: viewModel.isLocating ? AppTheme.greenAccent : AppTheme.textMuted) {
                    viewModel.requestUserLocation()
                }

                // Reset về trung tâm tỉnh
                DarkFAB(icon: "arrow.counterclockwise", accentColor: AppTheme.textMuted) {
                    viewModel.selectProvince(viewModel.selectedProvince)
                }
            }
            .padding(.trailing, 14)
            .padding(.bottom, viewModel.isFullScreenMode ? 60 : 250)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            // ── 7. LocationInfoPopup (Card nổi khi tap bản đồ, chuẩn Android/Web) ──
            if let parcel = viewModel.tappedPopupParcel {
                VStack {
                    Spacer()
                    LocationInfoPopup(
                        parcel: parcel,
                        onDismiss: { viewModel.tappedPopupParcel = nil },
                        onOpenDetail: {
                            viewModel.inspectedParcel = parcel
                            viewModel.tappedPopupParcel = nil
                            viewModel.isShowingParcelDetail = true
                        }
                    )
                    .padding(.horizontal, 14)
                    .padding(.bottom, 34)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.tappedPopupParcel != nil)
            }

            // ── 8. Bảng Điều Khiển Thời Kỳ & Độ Mờ Đục Phía Dưới (ẩn fullscreen + khi có popup) ──
            if !viewModel.isFullScreenMode && viewModel.tappedPopupParcel == nil {
                VStack(spacing: 10) {
                    // === 8.1. Thanh Chọn Thời Kỳ Quy Hoạch Chuẩn Guland ===
                    HStack(spacing: 8) {
                        ForEach([
                            (PlanningPeriod.qh2030, "QH 2030"),
                            (PlanningPeriod.khHangNam, "KH 2026"),
                            (PlanningPeriod.qhKhac, "QH khác")
                        ], id: \.1) { period, title in
                            let isSelected = viewModel.selectedPeriod == period
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.selectPeriod(period)
                                }
                            }) {
                                HStack(spacing: 5) {
                                    Circle()
                                        .fill(isSelected ? Color.black : AppTheme.greenAccent)
                                        .frame(width: 6, height: 6)
                                    Text(title)
                                        .font(.system(size: 12, weight: isSelected ? .bold : .semibold))
                                        .foregroundColor(isSelected ? .black : AppTheme.textLight)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(isSelected ? AppTheme.greenAccent : AppTheme.darkItemBg)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isSelected ? AppTheme.greenAccent : AppTheme.darkBorder, lineWidth: 1)
                                )
                            }
                        }
                    }

                    // === 8.2. Độ mờ quy hoạch ===
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(AppTheme.greenAccent)
                        Text("Độ mờ quy hoạch")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(AppTheme.textLight)
                        Spacer()
                        Text(viewModel.opacityValue < 0.05 ? "Chỉ Google Maps" : "\(Int(viewModel.opacityValue * 100))%")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(viewModel.opacityValue < 0.05 ? AppTheme.blueAccent : AppTheme.greenAccent)
                    }

                    Slider(value: $viewModel.opacityValue, in: 0.0...1.0, step: 0.01)
                        .accentColor(AppTheme.greenAccent)

                    // 3 preset nhanh chuẩn Android
                    HStack(spacing: 6) {
                        ForEach([(0.0, "0% Google Maps"), (0.5, "50%"), (1.0, "100%")], id: \.0) { val, label in
                            let isActive = abs(viewModel.opacityValue - val) < 0.05
                            Button(action: { viewModel.setOpacity(val) }) {
                                Text(label)
                                    .font(.system(size: 11, weight: isActive ? .bold : .medium))
                                    .foregroundColor(isActive ? AppTheme.greenAccent : AppTheme.textMuted)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 7)
                                    .background(isActive ? AppTheme.greenAccent.opacity(0.15) : AppTheme.darkItemBg)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(isActive ? AppTheme.greenAccent : AppTheme.darkBorder, lineWidth: 1)
                                    )
                            }
                        }
                    }

                    HStack(spacing: 8) {
                        Button(action: { viewModel.isShowingLegendSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "paintpalette.fill")
                                Text("Chú giải màu đất")
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(AppTheme.greenAccent)
                            .cornerRadius(10)
                        }

                        Button(action: { viewModel.setOpacity(viewModel.opacityValue > 0.1 ? 0.0 : 0.75) }) {
                            HStack(spacing: 6) {
                                Image(systemName: viewModel.opacityValue > 0.1 ? "eye.slash.fill" : "eye.fill")
                                Text(viewModel.opacityValue > 0.1 ? "Ẩn QH" : "Hiện QH")
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            .foregroundColor(AppTheme.textLight)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(AppTheme.darkItemBg)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(AppTheme.darkBorder, lineWidth: 1))
                        }
                    }
                }
                .padding(14)
                .background(AppTheme.darkPanelBg.opacity(0.95))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.darkBorder, lineWidth: 1))
                .shadow(color: Color.black.opacity(0.5), radius: 14, x: 0, y: -4)
                .padding(.horizontal, 14)
                .padding(.bottom, 24)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }

            // ── 9. Hộp Thoại Đi Tới Vị Trí Quy Hoạch (Deep Link / Link Paste / GPS) ──
            if let prompt = viewModel.locationPrompt {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()
                    .zIndex(20)

                VStack(spacing: 16) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(AppTheme.greenAccent)

                    Text("Đi tới vị trí quy hoạch?")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(AppTheme.textLight)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Phát hiện từ \(prompt.source):")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.textMuted)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Vĩ độ (Lat): \(String(format: "%.6f", prompt.latitude))")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppTheme.textLight)
                            Text("Kinh độ (Long): \(String(format: "%.6f", prompt.longitude))")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppTheme.textLight)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.darkItemBg)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppTheme.darkBorder, lineWidth: 1))
                    }

                    HStack(spacing: 12) {
                        Button(action: { viewModel.dismissLocationPrompt() }) {
                            Text("Bỏ qua")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(AppTheme.textMuted)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(AppTheme.darkItemBg)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(AppTheme.darkBorder, lineWidth: 1))
                        }

                        Button(action: { viewModel.confirmLocationPrompt() }) {
                            Text("Đến vị trí này")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(AppTheme.greenAccent)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(20)
                .background(AppTheme.darkPanelBg)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.darkBorder, lineWidth: 1))
                .shadow(color: Color.black.opacity(0.6), radius: 20, x: 0, y: 8)
                .padding(.horizontal, 30)
                .zIndex(21)
                .transition(.scale.combined(with: .opacity))
            }
        }
        // ── Sheets & Modals ──
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
        // Cập nhật tappedPopupParcel khi inspectedParcel thay đổi (từ map tap)
        .onChange(of: viewModel.inspectedParcel) { parcel in
            if let p = parcel, viewModel.tappedPopupParcel == nil {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    viewModel.tappedPopupParcel = p
                    viewModel.inspectedParcel = nil
                }
            }
        }
        .preferredColorScheme(.dark) // Force Dark Mode - chuẩn Android/Web
    }
}

// MARK: - Dark FAB Button chuẩn Android Glassmorphism
struct DarkFAB: View {
    let icon: String
    var accentColor: Color = AppTheme.textLight
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            DarkFABView(icon: icon, accentColor: accentColor)
        }
    }
}

struct DarkFABView: View {
    let icon: String
    var accentColor: Color = AppTheme.textLight

    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.darkPanelBg.opacity(0.9))
                .frame(width: 44, height: 44)
                .overlay(Circle().stroke(AppTheme.darkBorder, lineWidth: 1))
                .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 2)

            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(accentColor)
        }
    }
}

// MARK: - Placeholder modifier (cho TextField dark)
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
