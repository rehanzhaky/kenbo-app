import Foundation

/// A service to interact with the Gemini AI API for generating humor-themed content.
class AIService {
    static let shared = AIService()
    
    private let apiKey = AppConfig.geminiApiKey
    private let endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"
    
    private init() {}
    
    /// Generates humorous motivation or story in Bahasa Indonesia based on the type.
    func generateContent(prompt: String) async -> String? {
        guard !apiKey.isEmpty else {
            return "Kumpulkan XP terus ya biar makin bugar! (API Key belum diatur)"
        }
        
        var request = URLRequest(url: URL(string: "\(endpoint)?key=\(apiKey)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "contents": [[
                "parts": [["text": prompt]]
            ]]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let candidates = json["candidates"] as? [[String: Any]],
               let firstCandidate = candidates.first,
               let content = firstCandidate["content"] as? [String: Any],
               let parts = content["parts"] as? [[String: Any]],
               let text = parts.first?["text"] as? String {
                return text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            print("AI Service Error: \(error)")
        }
        
        return nil
    }
    
    func generateMotivationPrompt() -> String {
        return "Berikan quote motivasi singkat yang sangat lucu dan absurd tentang kebugaran dalam Bahasa Indonesia. Gunakan gaya bahasa 'Humor Academy' yang santai dan berisi 'xixi'. Maksimal 2 kalimat."
    }
    
    func generateStoryPrompt() -> String {
        return "Ceritakan kisah singkat (maksimal 3 paragraf) yang sangat lucu dan absurd tentang seorang ksatria yang sedang diet atau olahraga tapi gagal total karena hal sepele. Gunakan Bahasa Indonesia dengan gaya 'Humor Academy' yang santai dengan bumbu 'xixi'."
    }
}
