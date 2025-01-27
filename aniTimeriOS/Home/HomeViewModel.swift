//
//  HomeViewModel.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 11/01/25.
//

import Foundation
import UIKit

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
                self.animeDataByGenre[genre] = animeResponse.anime // Store data by genre
                self.onDataUpdated?() // Notify the view controller
                completion(animeResponse.anime) // Return fetched data
            case .failure(let error):
                print("Error fetching anime for genre \(genre): \(error)")
                completion([]) // Return empty array on failure
            }
        }
    }
    
    func fetchAnimeCellImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.lastPathComponent // Use a unique key, like the filename
        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            completion(cachedImage) // Return the cached image
            return
        }

        // Download the image if not cached
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            // Save to cache
            ImageCache.shared.saveImage(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
    
    func animeDataForGenre(_ genre: String) -> [Anime] {
           return animeDataByGenre[genre] ?? []
       }

}
