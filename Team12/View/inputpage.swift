import SwiftUI

struct inputpage: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                circularIconButton(systemName: "book.fill") { }
                Spacer()
                circularIconButton(systemName: "sun.max.circle.fill") { }
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)
            
            Spacer(minLength: 40)
            
            Text("اكتب هنا")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.maingreen)
                .shadow(color: .maingreen.opacity(0.18), radius: 4, x: 0, y: 3)
            
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
                    .frame(height: 260)
                
                TextEditor(text: $text)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(height: 260)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .multilineTextAlignment(.trailing)
                
                if text.isEmpty {
                    Text("السلام عليكم ...")
                        .foregroundColor(.lightgray)
                        .padding(.top, 20)
                        .padding(.trailing, 24)
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            Button(action: { }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
            }
            .background(
                Capsule()
                    .fill(Color.maingreen)
                    .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 6)
            )
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
    }
}

private func circularIconButton(systemName: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        ZStack {
            Circle()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
                .frame(width: 56, height: 56)
            
            Image(systemName: systemName)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.maingreen)
        }
    }
    .buttonStyle(.plain)
}

#Preview {
    inputpage()
}

