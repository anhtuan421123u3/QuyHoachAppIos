import SwiftUI

/// Card nổi bo tròn hiển thị thông tin thửa đất khi chạm bản đồ
/// Đồng bộ 100% với Android LocationInfoPopup.kt và Web FeaturePopup.jsx
struct LocationInfoPopup: View {
    let parcel: Parcel
    let onDismiss: () -> Void
    let onOpenDetail: () -> Void

    @State private var showCopied = false

    var body: some View {
        VStack(spacing: 0) {
            // === Header ===
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 15))
                        .foregroundColor(AppTheme.greenAccent)
                    Text("Vị trí đã chọn")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(AppTheme.textLight)
                }
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppTheme.textMuted)
                        .frame(width: 28, height: 28)
                        .background(AppTheme.darkItemBg)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()
                .background(AppTheme.darkBorder)

            // === Thông tin thửa đất ===
            VStack(spacing: 8) {
                let coordStr = String(format: "%.6f, %.6f", parcel.latitude, parcel.longitude)
                InfoRow(label: "Tọa độ", value: coordStr)
                if !parcel.provinceName.isEmpty {
                    InfoRow(label: "Tỉnh/TP", value: parcel.provinceName)
                }
                InfoRow(label: "Quy hoạch", value: parcel.note)
                if !parcel.planningLandType.name.isEmpty {
                    InfoRow(label: "Loại đất", value: parcel.planningLandType.name)
                }
                InfoRow(label: "Mã quy hoạch", value: parcel.planningLandType.code)
                if !parcel.sheetNumber.isEmpty {
                    InfoRow(label: "Số tờ", value: parcel.sheetNumber)
                }
                if !parcel.plotNumber.isEmpty {
                    InfoRow(label: "Số thửa", value: parcel.plotNumber)
                }
                InfoRow(label: "Diện tích", value: "\(Int(parcel.area)) m²")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            Divider()
                .background(AppTheme.darkBorder)

            // === Nút hành động ===
            HStack(spacing: 8) {
                // Nút Sao chép
                Button(action: {
                    let coordStr = String(format: "%.6f, %.6f", parcel.latitude, parcel.longitude)
                    UIPasteboard.general.string = coordStr
                    withAnimation(.spring(response: 0.3)) { showCopied = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation { showCopied = false }
                    }
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: showCopied ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 12))
                        Text(showCopied ? "Đã sao chép" : "Sao chép")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(AppTheme.greenAccent)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(AppTheme.greenAccent.opacity(0.12))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppTheme.greenAccent.opacity(0.4), lineWidth: 1)
                    )
                }

                // Nút Mở bản đồ chỉ đường
                Menu {
                    Button(action: {
                        let url = URL(string: "maps://?q=\(parcel.latitude),\(parcel.longitude)")!
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Mở Apple Maps", systemImage: "map")
                    }
                    Button(action: {
                        let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(parcel.latitude),\(parcel.longitude)")!
                        UIApplication.shared.open(url)
                    }) {
                        Label("Mở Google Maps", systemImage: "globe")
                    }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "arrow.triangle.turn.up.right.diamond")
                            .font(.system(size: 12))
                        Text("Dẫn đường")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(AppTheme.blueAccent)
                    .cornerRadius(8)
                }

                // Nút Chi tiết
                Button(action: onOpenDetail) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.textLight)
                        .frame(width: 38, height: 38)
                        .background(AppTheme.darkItemBg)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppTheme.darkBorder, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(AppTheme.darkPanelBg)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.35), radius: 16, x: 0, y: -4)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.darkBorder, lineWidth: 1)
        )
    }
}

// MARK: - InfoRow (chuẩn Android LocationInfoPopup.kt)
private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(AppTheme.textMuted)
                .frame(width: 88, alignment: .leading)
            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.textLight)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
