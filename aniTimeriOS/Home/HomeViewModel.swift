//
//  HomeViewModel.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 11/01/25.
//

import Foundation

class HomeViewModel {
    
    // Dictionary to store anime data for each genre
    var animeDataByGenre: [String: [Anime]] = [:]
    
    // Closure to notify the view controller when data is updated
    var onDataUpdated: (() -> Void)?
    
    // Fetch anime data for a specific genre
    func fetchAnimeForGenres(genre: String, completion: @escaping ([Anime]) -> Void) {
        RequestManager.shared.sendRequest(endpoint: "anime", parameters: ["genres": genre]) { (result: Result<AnimeResponse, Error>) in
            switch result {
            case .success(let animeResponse):
                completion(animeResponse.anime) // Pass the `anime` array to the completion
            case .failure(let error):
                print("Error fetching anime for genre \(genre): \(error)")
                completion([]) // Return an empty array on failure
            }
        }
    }
}
