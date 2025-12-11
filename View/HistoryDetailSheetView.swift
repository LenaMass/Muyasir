import SwiftUI

struct HistoryDetailSheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ResultViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 28) {

                    Text("النص المبسط")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    Text(viewModel.outputText)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.secondarySystemBackground))
                        )

                    Text("لغة الإشارة")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    VStack(alignment: .trailing, spacing: 10) {
                        ForEach(viewModel.handLines.indices, id: \.self) { i in
                            HStack(spacing: 6) {
                                ForEach(viewModel.handLines[i], id: \.self) { img in
                                    Image(img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                }
                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.secondarySystemBackground))
                    )
                }
                .padding(24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("عرض التفاصيل")
        }
        // ❗️ APPLY RTL HERE
        .environment(\.layoutDirection, .rightToLeft)
    }
}
