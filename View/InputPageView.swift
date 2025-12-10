import SwiftUI
import UIKit


struct RTLTextEditor: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.textAlignment = .right
        view.semanticContentAttribute = .forceRightToLeft
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RTLTextEditor
        init(_ parent: RTLTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
struct InputPageView: View {
    @StateObject private var viewModel = InputPageViewModel()
//    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showHistory = false
    @FocusState private var isTextEditorFocused: Bool   // focus for keyboard

    

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                HStack {
                    Button {
                        showHistory = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0.8)
                                )
                                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            
                            Image(systemName: "book.fill")
                                .font(.title3.bold())
                                .foregroundColor(.maingreen)
                        }
                        .frame(width: 40, height: 40)
                    }

                    Spacer()

                    Text(" الإدخال")
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    Spacer()

//                    Button {
//                        withAnimation(.easeInOut(duration: 0.25)) {
//                            isDarkMode.toggle()
//                        }
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 14)
//                                .fill(.ultraThinMaterial)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 14)
//                                        .stroke(Color.white.opacity(0.6), lineWidth: 0.8)
//                                )
//                                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
//                            
//                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
//                                .font(.title3.bold())
//
//                                .foregroundColor(.maingreen)
//                        }
//                        .frame(width: 40, height: 40)
//                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
                
                Spacer(minLength: 40)
                
                HStack(spacing: 8) {
                    ForEach(["ا", "ك", "ت", "ب", " ", "ه", "ن", "ا"], id: \.self) { letter in
                        if letter == " " {
                            Spacer().frame(width: 12)
                        } else {
                            Image(letter)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 40)
                        }
                    }
                }
                .environment(\.layoutDirection, .rightToLeft)
                .padding(.top, 10)
                
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                        .frame(height: 260)

                    
                    if viewModel.text.isEmpty {
                        Text("اكتب هنا")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                            .padding(.leading, 24)
                    }

                    RTLTextEditor(text: $viewModel.text)
                        .font(.body)
                        .frame(height: 260)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                }

                .padding(.horizontal, 32)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.submit()
                    }
                } label: {
                    HStack(spacing: 8) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "arrow.right")
                                .font(.title3.bold())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .foregroundColor(.white)
                }
                .disabled(viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
                .background(
                    Capsule()
                        .fill(
                            Color.maingreen.opacity(
                                viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading ? 0.5 : 1
                            )
                        )
                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 6)
                )
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                .navigationDestination(isPresented: $viewModel.shouldNavigate) {
                    if let simplified = viewModel.simplifiedText {
                        ResultPageView(viewModel: ResultViewModel(simplifiedText: simplified))
                    }
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
            .background(Color(.systemBackground))   // page background adapts
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
            }

            .navigationDestination(isPresented: $showHistory) {
                HistoryPageView()
            }
        }
//        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    InputPageView()
}
