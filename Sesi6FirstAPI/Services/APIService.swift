//
//  APIService.swift
//  Sesi6FirstAPI
//
//  Created by MacBook Pro on 19/04/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func fetchJokeServices() async throws -> Joke {
        let urlString = URL(string: Constants.jokeAPI)
        
        guard let url = urlString else {
            print("😡 ERROR: Could not convert \(Constants.jokeAPI) to a URL")
            throw URLError(.badURL)
        }
                  
        print("🕸️ We are accessing the url \(url)")
                  
        let (data, response) = try await URLSession.shared.data(from: url)
                  
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
                  
        guard(200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let joke = try JSONDecoder().decode(Joke.self, from: data)
        return joke
    }
}

/// kENAPA PAKAI CLASS?
/// 1. Untuk memastikan bahwa hanaya ada satu objek (instance) bersama (shared)
///   yang akan digunakan di seluruh aplikasi. Konsep ini disebut dengan singleton
///
/// 2. Jadi, nanti setiap ada perubahan state di bagian lain dari aplikasi 
///   kita, state nya akan sama. Seperti konsep mobil yang diubah warna tadi.
///
/// 3. Cara pemanggilanya, APIService.shared
/// 4. Untuk menceagah agar si objek  APIService tidak di re-create diluar kelas

