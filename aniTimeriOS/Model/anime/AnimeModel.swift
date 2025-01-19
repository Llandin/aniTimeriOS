//
//  AnimeModel.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 13/01/25.
//

import Foundation

struct AnimeResponse: Decodable {
    let page: Int
    let totalAmount: Int
    let anime: [Anime] // Array of Anime objects, optional
}

struct Anime: Decodable {
    let id: String?
    let title: String?
    let year: Int?
    let description: String?
    let genres: [AnimeGenre]?
    let studios: [Studio]?
    let episodes: Int?  // Optional
    let lengthMin: Int? // Optional
    let status: String?
    let imageVersionRoute: String?
    let stats: AnimeStats?
    let websites: AnimeWebsites?
}

struct AnimeGenre: Decodable {
    let name: String?
    let route: String?
}

struct Studio: Decodable {
    let name: String?
    let route: String?
}

struct AnimeStats: Decodable {
    let averageScore: Double?
    let ratingCount: Int?
    let trackedCount: Int?
    let trackedRating: Int?
    let colorLightMode: String?
    let colorDarkMode: String?
}

struct AnimeWebsites: Decodable {
    let official: String?
    let mal: String?
    let aniList: String?
    let kitsu: String?
    let animePlanet: String?
    let anidb: String?
    let crunchyroll: String?
    let funimation: String?
    let netflix: String?
}
