//
//  JokeVM.swift
//  Sesi6FirstAPI
//
//  Created by MacBook Pro on 19/04/24.
//

import Foundation

@MainActor
class JokeVM: ObservableObject {
    @Published var joke: Joke?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchJoke() async {
        isLoading = true
        errorMessage = nil
        
        do {
            joke = try await APIService.shared.fetchJokeServices()
            print("Setup: \(joke?.setup ?? "No Setup")")
            print("Punchline: \(joke?.punchline ?? "No Punchline")")
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading =  false
            print("Error: Could not get data from URL: \(Constants.jokeAPI).\(error.localizedDescription)")
        }
    }
}
