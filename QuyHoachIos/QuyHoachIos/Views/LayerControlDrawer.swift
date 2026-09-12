import SwiftUI

/// Menu điều khiển lớp quy hoạch chuẩn Dark Glassmorphism - đồng bộ 100% với Android LayerControlDrawer.kt và Web LayerControlPanel.jsx
struct LayerControlDrawer: View {
    @ObservedObject var viewModel: MapViewModel
    let onClose: () -> Void

    @State private var isRasterSectionOpen: Bool = true
    @State private var isLegendSectionOpen: Bool = true

    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                // === 1. Panel Header: Brand + Nút đóng ===
                HStack {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(AppTheme.greenGlow)
                            .frame(width: 10, height: 10)
                            .shadow(color: AppTheme.greenGlow.opacity(0.8), radius: 4, x: 0, y: 0)
                        Text("QuyHoachVietNam")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(AppTheme.textLight)
                    }
                    Spacer()
                    Button(action: onClose) {
                        Text("✕")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textMuted)
                            .frame(width: 32, height: 28)
                            .background(AppTheme.darkItemBg)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(AppTheme.darkBorder, lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)

                Divider()
                    .background(AppTheme.darkBorder)

                // === Nội dung cuộn ===
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 14) {

                        // === 2. Dropdown Chọn Tỉnh/Thành Phố ===
                        Button(action: {
                            viewModel.isShowingProvincePicker = true
                        }) {
                            HStack {
                                HStack(spacing: 8) {
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(AppTheme.greenAccent)
                                    Text(viewModel.selectedProvince.name)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppTheme.textLight)
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12))
                                    .foregroundColor(AppTheme.textMuted)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(AppTheme.darkItemBg)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppTheme.darkBorder, lineWidth: 1)
                            )
                        }

                        // === 3. Tiêu đề quy hoạch ===
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Quy hoạch sử dụng đất \(viewModel.selectedProvince.name)")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(AppTheme.textLight)
                            Text("\(viewModel.availableLayers.count) Bản đồ quy hoạch · Toàn tỉnh")
                                .font(.system(size: 11))
                                .foregroundColor(AppTheme.textMuted)
                        }

                        Divider()
                            .background(AppTheme.darkBorder)

                        // === 4. Master Opacity Slider + 3 Nút Preset ===
                        VStack(spacing: 6) {
                            HStack {
                                Text("Độ mờ quy hoạch")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(AppTheme.textLight)
                                Spacer()
                                Text(viewModel.opacityValue < 0.05 ? "Chỉ Google Maps" : "\(Int(viewModel.opacityValue * 100))%")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(viewModel.opacityValue < 0.05 ? AppTheme.blueAccent : AppTheme.greenAccent)
                            }

                            Slider(value: $viewModel.opacityValue, in: 0.0...1.0, step: 0.01)
                                .accentColor(AppTheme.greenAccent)
                                .onChange(of: viewModel.opacityValue) { _ in
                                    viewModel.setOpacity(viewModel.opacityValue)
                                }

                            // 3 Nút Preset nhanh - chuẩn 100% Android & Web
                            HStack(spacing: 6) {
                                ForEach([(0.0, "0% Google Maps"), (0.5, "50%"), (1.0, "100%")], id: \.0) { val, label in
                                    let isActive = abs(viewModel.opacityValue - val) < 0.05
                                    Button(action: { viewModel.setOpacity(val) }) {
                                        Text(label)
                                            .font(.system(size: 10, weight: isActive ? .bold : .medium))
                                            .foregroundColor(isActive ? AppTheme.greenAccent : AppTheme.textMuted)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 6)
                                            .background(isActive ? AppTheme.greenAccent.opacity(0.18) : AppTheme.darkItemBg)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(isActive ? AppTheme.greenAccent : AppTheme.darkBorder, lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }

                        Divider()
                            .background(AppTheme.darkBorder)

                        // === 4.5. Bộ Lọc Thời Kỳ Quy Hoạch ===
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Thời kỳ quy hoạch")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(AppTheme.textLight)

                            HStack(spacing: 6) {
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
                                        Text(title)
                                            .font(.system(size: 11, weight: isSelected ? .bold : .medium))
                                            .foregroundColor(isSelected ? .black : AppTheme.textMuted)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 7)
                                            .background(isSelected ? AppTheme.greenAccent : AppTheme.darkItemBg)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(isSelected ? AppTheme.greenAccent : AppTheme.darkBorder, lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }

                        Divider()
                            .background(AppTheme.darkBorder)

                        // === 5. Danh Sách Layer Quy Hoạch (Accordion) ===
                        VStack(alignment: .leading, spacing: 8) {
                            Button(action: { withAnimation(.easeInOut(duration: 0.2)) { isRasterSectionOpen.toggle() } }) {
                                HStack {
                                    Text("🗺️ \(viewModel.availableLayers.count) Bản đồ Quy hoạch \(viewModel.selectedProvince.name)")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(AppTheme.textLight)
                                    Spacer()
                                    Image(systemName: isRasterSectionOpen ? "chevron.up" : "chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(AppTheme.textMuted)
                                }
                                .padding(.vertical, 4)
                            }

                            if isRasterSectionOpen {
                                VStack(spacing: 4) {
                                    ForEach(viewModel.availableLayers) { layer in
                                        let isSelected = layer.id == viewModel.activeLayer?.id
                                        Button(action: { viewModel.selectLayer(layer) }) {
                                            HStack(spacing: 8) {
                                                // Radio button visual
                                                Circle()
                                                    .fill(isSelected ? AppTheme.greenAccent : Color.clear)
                                                    .frame(width: 14, height: 14)
                                                    .overlay(
                                                        Circle()
                                                            .stroke(isSelected ? AppTheme.greenAccent : AppTheme.textMuted, lineWidth: 1.5)
                                                    )

                                                // Chấm màu layer
                                                Circle()
                                                    .fill(Color(hex: layer.colorHex))
                                                    .frame(width: 8, height: 8)

                                                Text(layer.label)
                                                    .font(.system(size: 12, weight: isSelected ? .bold : .medium))
                                                    .foregroundColor(isSelected ? AppTheme.textLight : AppTheme.textMuted)
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(maxWidth: .infinity, alignment: .leading)

                                                // Vector badge
                                                if layer.isVector {
                                                    Text("Vector")
                                                        .font(.system(size: 9, weight: .bold))
                                                        .foregroundColor(AppTheme.greenAccent)
                                                        .padding(.horizontal, 5)
                                                        .padding(.vertical, 2)
                                                        .background(AppTheme.greenAccent.opacity(0.18))
                                                        .cornerRadius(4)
                                                }
                                            }
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 7)
                                            .background(isSelected ? AppTheme.greenAccent.opacity(0.12) : Color.clear)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(isSelected ? AppTheme.greenAccent.opacity(0.35) : Color.clear, lineWidth: 1)
                                            )
                                        }
                                    }
                                }
                            }
                        }

                        Divider()
                            .background(AppTheme.darkBorder)

                        // === 6. Bảng Ghi Chú Màu Quy Hoạch ===
                        VStack(alignment: .leading, spacing: 8) {
                            Button(action: { withAnimation(.easeInOut(duration: 0.2)) { isLegendSectionOpen.toggle() } }) {
                                HStack {
                                    Text("Ghi chú màu quy hoạch")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(AppTheme.textLight)
                                    Spacer()
                                    Image(systemName: isLegendSectionOpen ? "chevron.up" : "chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(AppTheme.textMuted)
                                }
                                .padding(.vertical, 4)
                            }

                            if isLegendSectionOpen {
                                VStack(spacing: 6) {
                                    ForEach(Array(stride(from: 0, to: qhLandUseLegend.count, by: 2)), id: \.self) { idx in
                                        LegendRow(
                                            left: qhLandUseLegend[idx],
                                            right: idx + 1 < qhLandUseLegend.count ? qhLandUseLegend[idx + 1] : nil
                                        )
                                    }
                                }
                            }
                        }

                        // Bottom padding
                        Spacer().frame(height: 30)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                }
            }
            .frame(maxWidth: 320, maxHeight: .infinity)
            .background(AppTheme.darkPanelBg)
            .clipShape(RoundedRectangle(cornerRadius: 0))
            .overlay(
                Rectangle()
                    .fill(AppTheme.darkBorder)
                    .frame(width: 1),
                alignment: .trailing
            )

            Spacer() // Cho phép tap vào scrim bên ngoài
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

// MARK: - LegendRow helper (tránh lỗi let trong SwiftUI body)
private struct LegendRow: View {
    let left: LegendColorItem
    let right: LegendColorItem?

    var body: some View {
        HStack(spacing: 8) {
            legendCell(item: left)
            if let r = right {
                legendCell(item: r)
            } else {
                Spacer().frame(maxWidth: .infinity)
            }
        }
    }

    @ViewBuilder
    private func legendCell(item: LegendColorItem) -> some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex: item.colorHex))
                .frame(width: 12, height: 12)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.white.opacity(0.2), lineWidth: 0.5))
            Text(item.name)
                .font(.system(size: 10))
                .foregroundColor(AppTheme.textMuted)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
