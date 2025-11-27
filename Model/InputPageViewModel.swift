import Foundation
import Combine

@MainActor
final class InputPageViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var simplifiedText: String?
    @Published var shouldNavigate: Bool = false
    
    func submit() async {
        errorMessage = nil
        
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        isLoading = true
        do {
            let result = try await SimplifierService.shared.simplify(text: trimmed)
            simplifiedText = result
            shouldNavigate = true
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "error in server"
            print("Simplify error:", error)
        }
    }
}
