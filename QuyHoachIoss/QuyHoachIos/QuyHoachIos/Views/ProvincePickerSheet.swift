import SwiftUI

struct ProvincePickerSheet: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Thanh tìm kiếm tỉnh
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Tìm tỉnh/thành phố toàn quốc...", text: $viewModel.provinceFilterText)
                        .font(.system(size: 15))
                    if !viewModel.provinceFilterText.isEmpty {
                        Button(action: { viewModel.provinceFilterText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)

                // Phân loại 3 Miền
                Picker("Khu vực", selection: $viewModel.selectedRegion) {
                    ForEach(Region.allCases) { region in
                        Text(region.rawValue).tag(region)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)

                // Danh sách 63 tỉnh/thành
                List {
                    ForEach(viewModel.filteredProvinces) { province in
                        Button(action: {
                            viewModel.selectProvince(province)
                            dismiss()
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack(spacing: 6) {
                                        Text(province.name)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.primary)

                                        Text("\(String(format: "%.2f", province.centralMeridian))°")
                                            .font(.system(size: 10, weight: .bold))
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 1)
                                            .background(Color.blue.opacity(0.12))
                                            .foregroundColor(.blue)
                                            .cornerRadius(4)
                                    }

                                    Text(province.description)
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                if province.id == viewModel.selectedProvince.id {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18))
                                } else {
                                    Text(province.region.rawValue)
                                        .font(.system(size: 11, weight: .medium))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(6)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("63 Tỉnh Thành Toàn Quốc")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { dismiss() }
                        .font(.system(size: 15, weight: .semibold))
                }
            }
        }
    }
}
