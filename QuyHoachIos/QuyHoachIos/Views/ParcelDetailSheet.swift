import SwiftUI
import CoreLocation

struct ParcelDetailSheet: View {
    @State var parcel: Parcel
    var onBookmarkToggle: ((Parcel) -> Void)? = nil
    @Environment(\.dismiss) var dismiss
    @State private var userNote: String = ""
    @State private var isCopied: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header Card
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Thửa đất tra cứu")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.12))
                                .cornerRadius(8)

                            Spacer()

                            Text(parcel.landTypeCode)
                                .font(.system(size: 14, weight: .heavy))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color(hex: parcel.planningLandType.hexColor).opacity(0.2))
                                .foregroundColor(Color(hex: parcel.planningLandType.hexColor))
                                .cornerRadius(8)
                        }

                        Text("Tờ bản đồ số \(parcel.sheetNumber) - Thửa số \(parcel.plotNumber)")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundColor(.primary)

                        Text(parcel.address)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)

                    // Cảnh báo quy hoạch (nếu có)
                    if let warning = parcel.planningWarning {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 18))
                            Text(warning)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.orange)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.12))
                        .cornerRadius(12)
                    }

                    // Bảng Thông Số Chi Tiết
                    VStack(spacing: 12) {
                        DetailRow(icon: "ruler", label: "Diện tích thửa đất", value: "\(String(format: "%.1f", parcel.area)) m²")
                        DetailRow(icon: "tag.fill", label: "Mục đích sử dụng hiện trạng", value: "\(parcel.currentLandType.code) - \(parcel.currentLandType.name)")
                        DetailRow(icon: "map.fill", label: "Quy hoạch phân loại đất", value: "\(parcel.planningLandType.code) - \(parcel.planningLandType.name)")
                        DetailRow(icon: "doc.text.fill", label: "Hiện trạng pháp lý", value: parcel.legalNote)

                        // Ước tính giá trị & xây dựng
                        let totalPriceBillion = (parcel.area * parcel.estimatedPriceMillionPerM2) / 1000.0
                        DetailRow(
                            icon: "dollarsign.circle.fill",
                            label: "Giá tham khảo khu vực",
                            value: "\(String(format: "%.1f", parcel.estimatedPriceMillionPerM2)) tr/m² (~ \(String(format: "%.2f", totalPriceBillion)) tỷ VNĐ)"
                        )
                        DetailRow(icon: "building.2.fill", label: "Mật độ & Tầng cao tối đa", value: "\(parcel.buildingDensity) (Tối đa \(parcel.maxFloors))")

                        // Tọa độ GPS & VN-2000
                        DetailRow(
                            icon: "location.fill",
                            label: "Tọa độ GPS (WGS-84)",
                            value: "\(String(format: "%.6f", parcel.latitude)), \(String(format: "%.6f", parcel.longitude))"
                        )

                        if let x = parcel.vn2000X, let y = parcel.vn2000Y {
                            DetailRow(
                                icon: "square.grid.3x3.fill",
                                label: "Tọa độ VN-2000 (Sổ đỏ)",
                                value: "X: \(String(format: "%.2f", x)) | Y: \(String(format: "%.2f", y))"
                            )
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)

                    // Ghi chú cá nhân & Bookmark
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("GHI CHÚ RIÊNG")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: {
                                parcel.isBookmarked.toggle()
                                parcel.customNote = userNote
                                onBookmarkToggle?(parcel)
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: parcel.isBookmarked ? "bookmark.fill" : "bookmark")
                                    Text(parcel.isBookmarked ? "Đã lưu" : "Lưu thửa đất")
                                }
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(parcel.isBookmarked ? .orange : .blue)
                            }
                        }

                        TextField("Nhập ghi chú cho thửa đất này (ví dụ: đất mặt tiền, liên hệ 090...)", text: $userNote)
                            .font(.system(size: 13))
                            .padding(10)
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                    }
                    .padding(14)
                    .background(.ultraThinMaterial)
                    .cornerRadius(14)

                    // Các nút thao tác (Sao chép, Chỉ đường, Chia sẻ)
                    VStack(spacing: 10) {
                        Button(action: {
                            UIPasteboard.general.string = "\(parcel.latitude), \(parcel.longitude)"
                            isCopied = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isCopied = false
                            }
                        }) {
                            HStack {
                                Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                                Text(isCopied ? "Đã sao chép tọa độ GPS!" : "Sao chép tọa độ GPS (WGS84)")
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        HStack(spacing: 10) {
                            Button(action: { openAppleMaps() }) {
                                HStack {
                                    Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                                    Text("Apple Maps")
                                }
                                .font(.system(size: 13, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color(.systemGray5))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                            }

                            Button(action: { openGoogleMaps() }) {
                                HStack {
                                    Image(systemName: "safari.fill")
                                    Text("Google Maps")
                                }
                                .font(.system(size: 13, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color(.systemGray5))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Thông Tin Thửa Đất")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { dismiss() }
                }
            }
            .onAppear {
                userNote = parcel.customNote
            }
        }
    }

    private func openAppleMaps() {
        let urlStr = "maps://?daddr=\(parcel.latitude),\(parcel.longitude)&dirflg=d"
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    private func openGoogleMaps() {
        let urlStr = "https://www.google.com/maps/dir/?api=1&destination=\(parcel.latitude),\(parcel.longitude)"
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
}

struct DetailRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(.blue)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.primary)
            }
            Spacer()
        }
    }
}
