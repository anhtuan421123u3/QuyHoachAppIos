import SwiftUI

struct LegendSheet: View {
    let landTypes: [LandType]
    @Environment(\.dismiss) var dismiss
    @State private var filterQuery: String = ""
    @State private var selectedCategory: LandCategory? = nil

    var filteredTypes: [LandType] {
        var results = landTypes
        if let cat = selectedCategory {
            results = results.filter { $0.category == cat }
        }
        if filterQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return results
        }
        let query = filterQuery.lowercased()
        return results.filter {
            $0.code.lowercased().contains(query) ||
            $0.name.lowercased().contains(query) ||
            $0.category.rawValue.lowercased().contains(query)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Tra cứu mã đất (ví dụ: ODT, ONT, TMD, CLN, LUC...)", text: $filterQuery)
                        .font(.system(size: 14))
                    if !filterQuery.isEmpty {
                        Button(action: { filterQuery = "" }) {
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
                .padding(.bottom, 6)

                // Category chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        Button(action: { selectedCategory = nil }) {
                            Text("Tất cả")
                                .font(.system(size: 12, weight: selectedCategory == nil ? .bold : .medium))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(selectedCategory == nil ? Color.blue : Color(.systemGray6))
                                .foregroundColor(selectedCategory == nil ? .white : .primary)
                                .cornerRadius(16)
                        }

                        ForEach(LandCategory.allCases) { cat in
                            let isSel = selectedCategory == cat
                            Button(action: { selectedCategory = isSel ? nil : cat }) {
                                Text(cat.rawValue)
                                    .font(.system(size: 12, weight: isSel ? .bold : .medium))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(isSel ? Color.blue : Color(.systemGray6))
                                    .foregroundColor(isSel ? .white : .primary)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }

                List {
                    ForEach(LandCategory.allCases) { category in
                        let items = filteredTypes.filter { $0.category == category }
                        if !items.isEmpty {
                            Section(header: Text(category.rawValue).font(.system(size: 13, weight: .bold))) {
                                ForEach(items) { land in
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(alignment: .top, spacing: 12) {
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(Color(hex: land.hexColor))
                                                .frame(width: 32, height: 32)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 6)
                                                        .stroke(Color.black.opacity(0.12), lineWidth: 1)
                                                )

                                            VStack(alignment: .leading, spacing: 2) {
                                                HStack {
                                                    Text(land.code)
                                                        .font(.system(size: 15, weight: .heavy))
                                                        .foregroundColor(.blue)
                                                    Text("-")
                                                        .foregroundColor(.secondary)
                                                    Text(land.name)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .foregroundColor(.primary)
                                                }

                                                Text(land.description)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.secondary)
                                            }
                                        }

                                        // Badge Pháp lý & Chuyển đổi
                                        HStack(spacing: 8) {
                                            HStack(spacing: 4) {
                                                Image(systemName: land.canConvertToResidential ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(land.canConvertToResidential ? .green : .orange)
                                                Text(land.canConvertToResidential ? "Cho phép chuyển lên đất ở" : "Hạn chế chuyển đổi đất ở")
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundColor(land.canConvertToResidential ? .green : .orange)
                                            }
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background((land.canConvertToResidential ? Color.green : Color.orange).opacity(0.12))
                                            .cornerRadius(4)

                                            Spacer()

                                            Text(land.legalReference)
                                                .font(.system(size: 10))
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.leading, 44)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Chú Giải 30+ Mã Màu Đất")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Xong") { dismiss() }
                        .font(.system(size: 15, weight: .semibold))
                }
            }
        }
    }
}
