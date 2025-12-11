import SwiftUI

struct HistoryDetailSheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ResultViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .trailing, spacing: 28) {
                
                Spacer().frame(height: 30)
                
                // MARK: - Simplified Text
                Text("النص المبسط:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                ScrollView {
                    Text(viewModel.outputText)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                }
                .frame(height: 270)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                
                // MARK: - Sign Language Label
                Text("لغة الإشارة:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                ScrollView {
                    VStack(alignment: .trailing, spacing: 10) {
                        ForEach(viewModel.handLines.indices, id: \.self) { i in
                            HStack(spacing: 6) {
                                ForEach(viewModel.handLines[i], id: \.self) { img in
                                    Image(img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding()
                }
                .frame(height: 270)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
            }
            .padding(24)
            
            // MARK: - Close Button (Glass Effect)
            Button(action: {
                dismiss() // Close the sheet
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding([.top, .trailing], 16)
        }
    }
}


#Preview {
    HistoryDetailSheetView(
        viewModel: ResultViewModel(simplifiedText: "هذا نص تجريبي لعرض صفحة التفاصيل واختبار التمرير والمحاذاة من اليمين.")
    )
}
