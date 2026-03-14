import Foundation

/// A service to interact with the Gemini AI API for generating humor-themed content.
class AIService {
    static let shared = AIService()
    
    private let apiKey = AppConfig.geminiApiKey
    private let endpoint = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent"
    
    private init() {}
    
    struct RewardBundle: Decodable {
        let motivations: [String]
        let stories: [String]
        let titles: [String]
    }
    
    // MARK: - Localized Fallback Data
    struct DummyDataPool {
        static let titles = [
            "Si Bugar", "Si Sehat", "Si Paling Swift", "Si Anti Bug", "Si Master UI",
            "Si Jago Coding", "Si Penakluk Xcode", "Si Rajin Commit", "Si Otot Kawat Tulang Kode",
            "Si Gamifikasi Hidup", "Si Fullstack Tangguh", "Si Kreator Bugar", "Si Pemburu Solusi",
            "Si Pejuang Compile", "Si Tech Bro Sehat", "Si Paling Apple", "Si Arsitek Logika",
            "Si Penggerak Habit", "Si Sultan Git", "Si Paling Edutainment"
        ]
        
        static let motivations = [
            "Error di Xcode bukan akhir dunia, itu cuma Swift yang lagi ngajak kenalan lebih dalam. Keep coding!",
            "Figma-nya udah cakep, sekarang waktunya bikin SwiftUI-nya seindah ekspektasi. Kamu pasti bisa!",
            "Challenge phase terasa berat? Ingat, aplikasi hebat lahir dari puluhan kali 'Build Failed' yang akhirnya menjadi 'Build Succeeded'.",
            "MacBook dan iPhone di tanganmu itu alat tempur. Jadikan setiap baris kodemu langkah kecil menuju impact yang besar.",
            "Bikin aplikasi yang ngaruh buat gaya hidup orang banyak itu keren. Semangat wujudkan idemu dari sekadar coretan jadi nyata!",
            "Setiap bug yang kamu perbaiki hari ini adalah investasi skill problem-solving untuk karir engineering-mu di masa depan.",
            "Jangan cuma jadi pengguna ekosistem, jadilah pencipta di dalamnya. Dunia menunggu karya inovatifmu di App Store.",
            "Lelah itu wajar. Istirahatlah sejenak, tarik napas, lalu kembali ke Xcode dengan pikiran yang lebih jernih.",
            "Menjadi Fullstack AI Engineer memang butuh waktu. Tiap baris kode Swift yang kamu tulis untuk Bugaru membawamu satu langkah lebih dekat ke target besarmu di akhir tahun ini.",
            "Fokus pada roadmap sepuluh bulan ke depan. Setiap baris kode yang berhasil di-compile adalah fondasi menuju kebebasan finansial yang kamu rencanakan."
        ]
        
        static let stories = [
            "Udah debat panjang lebar sama tim soal UX design, pas mau di-code baru sadar Bundle ID-nya kepakai orang lain. Sedih tapi bikin ngakak.",
            "Mencoba bikin fitur gamifikasi buat ngingetin orang hidup sehat, tapi developernya sendiri lupa makan dan duduk 12 jam nonstop depan layar.",
            "Bangga banget pas demo aplikasi, animasinya mulus, UI-nya rapi. Pas di-klik tombol utamanya di depan mentor... 'App quit unexpectedly'. Panik nggak tuh?",
            "Ngetik kode sampai jam 3 pagi, ngerasa udah nemu algoritma paling jenius. Pas bangun pagi dilihat lagi, ternyata logikanya muter-muter nggak karuan.",
            "Lupa nutup bracket '}' di Swift, nyarinya seharian sampai mau nangis, di-scroll ke atas ke bawah, ternyata ada di file yang beda.",
            "Ngerasa jago banget pas sukses bikin button bulat sempurna di Simulator, eh pas di-run di iPhone asli bentuknya jadi lonjong kayak telur dinosaurus.",
            "Niatnya mau ngerjain Challenge pakai arsitektur yang canggih banget, ujung-ujungnya mentok berjam-jam di error Constraint Auto Layout yang merah semua.",
            "Ngoding sambil ngantuk berat, mau nulis variabel 'var isHealthy = true', malah nulis 'var isNgantuk = banget'. Di-compile ya jelas marah Xcode-nya.",
            "Udah ngerasa paling hacker sedunia pas berhasil nulis script di Zoho Deluge, pas beralih balik ke Swift malah nangis bombay gara-gara urusan Optional Unwrapping yang tanda tanyanya bikin overthinking."
        ]
        
        /// Returns a guaranteed array of 6 randomized items from the requested pool.
        static func getRandom(from pool: [String], count: Int = 6) -> [String] {
            return Array(pool.shuffled().prefix(count))
        }
    }
    
    // MARK: - API Methods
    func generateContent(prompt: String) async -> String? {
        if apiKey.isEmpty {
            print("Gemini API key is empty. Check Info.plist and Build Settings (GEMINI_API_KEY).")
            return "Kumpulkan XP terus ya biar makin bugar! (API Key belum diatur)"
        }
        
        var request = URLRequest(url: URL(string: "\(endpoint)?key=\(apiKey)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "contents": [[
                "parts": [["text": prompt]]
            ]],
            "generationConfig": [
                "responseMimeType": "application/json"
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                // Check for API errors (like invalid key)
                if let error = json["error"] as? [String: Any] {
                    let message = error["message"] as? String ?? "Unknown Error"
                    print("❌ Gemini API Error: \(message)")
                    return "ERROR: \(message)"
                }
                
                if let candidates = json["candidates"] as? [[String: Any]],
                   let firstCandidate = candidates.first,
                   let content = firstCandidate["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]],
                   let text = parts.first?["text"] as? String {
                    return text.trimmingCharacters(in: .whitespacesAndNewlines)
                } else {
                    print("❌ Failed to parse Gemini candidates: \(json)")
                }
            }
        } catch {
            print("AI Service Error: \(error)")
        }
        
        return nil
    }
    
    /// Generates motivation, story, and title arrays in one Gemini call.
    func generateRewardBundle() async -> RewardBundle? {
        let prompt = generateRewardBundlePrompt()
        guard let text = await generateContent(prompt: prompt) else { return nil }
        
        if text.hasPrefix("ERROR:") {
            print("Skipping JSON parse due to API error: \(text)")
            return nil
        }
        
        return parseRewardBundle(from: text)
    }
    
    func generateRewardBundlePrompt() -> String {
        return """
        Buat 3 kategori konten berikut dalam Bahasa Indonesia gaya Humor Academy yang santai, lucu, absurd, dan menyelipkan kata 'xixi':
        1) motivations: array motivasi singkat (1-2 kalimat per item), maksimal 6 item.
        2) stories: array cerita singkat (maksimal 3 paragraf per item), maksimal 6 item.
        3) titles: array gelar 2-3 kata yang terasa heroik dan kocak, maksimal 6 item.
        Kembalikan hanya JSON valid dengan key: motivations, stories, titles. Jangan tambahkan teks lain.
        """
    }
    
    func generateMotivationPrompt() -> String {
        return "Berikan quote motivasi singkat yang sangat lucu dan absurd tentang kebugaran dalam Bahasa Indonesia. Gunakan gaya bahasa 'Humor Academy' yang santai dan berisi 'xixi'. Maksimal 2 kalimat."
    }
    
    func generateStoryPrompt() -> String {
        return "Ceritakan kisah singkat (maksimal 3 paragraf) yang sangat lucu dan absurd tentang seorang ksatria yang sedang diet atau olahraga tapi gagal total karena hal sepele. Gunakan Bahasa Indonesia dengan gaya 'Humor Academy' yang santai dengan bumbu 'xixi'."
    }
    
    private func parseRewardBundle(from text: String) -> RewardBundle? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if let data = trimmed.data(using: .utf8),
           let bundle = try? JSONDecoder().decode(RewardBundle.self, from: data) {
            return bundle
        }
        
        if let start = trimmed.firstIndex(of: "{"),
           let end = trimmed.lastIndex(of: "}") {
            let jsonString = String(trimmed[start...end])
            if let data = jsonString.data(using: .utf8),
               let bundle = try? JSONDecoder().decode(RewardBundle.self, from: data) {
                return bundle
            }
        }
        
        return nil
    }
}
