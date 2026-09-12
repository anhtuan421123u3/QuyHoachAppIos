import SwiftUI

struct BaseMapPickerSheet: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Chọn kiểu bản đồ nền hiển thị phía dưới lớp phủ quy hoạch đất đai")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(MapBackgroundType.allCases) { type in
                        let isSelected = viewModel.mapBackground == type
                        Button(action: {
                            viewModel.setMapBackground(type)
                            dismiss()
                        }) {
                            VStack(spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(isSelected ? Color.blue.opacity(0.15) : Color(.systemGray6))
                                        .frame(height: 90)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                                        )

                                    VStack(spacing: 6) {
                                        Image(systemName: type.icon)
                                            .font(.system(size: 28))
                                            .foregroundColor(isSelected ? .blue : .primary)

                                        if isSelected {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 14))
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }

                                Text(type.rawValue)
                                    .font(.system(size: 13, weight: isSelected ? .bold : .medium))
                                    .foregroundColor(isSelected ? .blue : .primary)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)

                Spacer()
            }
            .navigationTitle("Kiểu Bản Đồ Nền")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Xong") { dismiss() }
                }
            }
        }
    }
}
