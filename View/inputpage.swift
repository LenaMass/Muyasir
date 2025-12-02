import SwiftUI

struct inputpage: View {
    @StateObject private var viewModel = InputPageViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showHistory = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                HStack {
                    ZStack {
                        NavigationLink(destination: HistoryView(), isActive: $showHistory) {
                            EmptyView()
                        }

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
                                    .font(.system(size: 20))
                                    .foregroundColor(.maingreen)
                            }
                            .frame(width: 40, height: 40)
                        }
                    }

                    Spacer()
                    
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0.8)
                                )
                                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.maingreen)
                        }
                        .frame(width: 40, height: 40)
                    }
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
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
                        .frame(height: 260)
                    
                    TextEditor(text: $viewModel.text)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .frame(height: 260)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .multilineTextAlignment(.trailing)
                    
                    if viewModel.text.isEmpty {
                        Text("السلام عليكم ...")
                            .foregroundColor(.lightgray)
                            .padding(.top, 20)
                            .padding(.trailing, 24)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
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
                                .font(.system(size: 24, weight: .medium))
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
                        ResultView(viewModel: ResultViewModel(simplifiedText: simplified))
                    }
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

#Preview {
    inputpage()
}
