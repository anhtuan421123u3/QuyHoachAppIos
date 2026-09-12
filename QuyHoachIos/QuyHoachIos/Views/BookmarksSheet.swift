import SwiftUI

struct BookmarksSheet: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.savedParcels.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "bookmark.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        Text("Chưa có thửa đất nào được lưu")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                        Text("Khi tra cứu thửa đất trên bản đồ, bạn có thể nhấn nút Lưu để xem lại nhanh tại đây.")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.savedParcels) { parcel in
                            Button(action: {
                                viewModel.targetCoordinate = parcel.coordinate
                                viewModel.inspectedParcel = parcel
                                viewModel.isShowingParcelDetail = true
                                dismiss()
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Tờ \(parcel.sheetNumber) - Thửa \(parcel.plotNumber)")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.primary)

                                        Spacer()

                                        Text(parcel.landTypeCode)
                                            .font(.system(size: 12, weight: .heavy))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 3)
                                            .background(Color(hex: parcel.planningLandType.hexColor).opacity(0.2))
                                            .foregroundColor(Color(hex: parcel.planningLandType.hexColor))
                                            .cornerRadius(6)
                                    }

                                    Text(parcel.address)
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)

                                    if !parcel.customNote.isEmpty {
                                        HStack(alignment: .top, spacing: 4) {
                                            Image(systemName: "note.text")
                                                .font(.system(size: 12))
                                                .foregroundColor(.blue)
                                            Text(parcel.customNote)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.blue)
                                                .lineLimit(2)
                                        }
                                        .padding(6)
                                        .background(Color.blue.opacity(0.08))
                                        .cornerRadius(6)
                                    }

                                    HStack {
                                        Text("Diện tích: \(String(format: "%.1f", parcel.area)) m²")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.primary)

                                        Spacer()

                                        if let dt = parcel.savedDate {
                                            Text("Lưu: \(dt, style: .date)")
                                                .font(.system(size: 11))
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteSavedParcel(parcel)
                                } label: {
                                    Label("Xóa", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Thửa Đất Đã Lưu (\(viewModel.savedParcels.count))")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { dismiss() }
                }
            }
        }
    }
}
