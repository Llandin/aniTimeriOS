//
//  AnimeMockedData.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 10/10/24.
//

// Updated structure based on the original format
struct MockAnimeData {
    let id: String?
    let title: Title? // Using a nested Title structure to match the original data
    let description: String?
    let episodes: Int?
    let genres: [String]? // Using an array of strings for genres
    let bannerImage: String?
    let coverImage: CoverImage?
    let localCoverImage: String?
    let localBannerImage: String?
    var isFavorite: Bool
    let airing: String?
//    let category: AnimeCategory
    let remainingDays: Int
    let image:String
}

struct CoverImage {
    let large: String?
    let medium: String?
}

// Nested Title struct to match the original format
struct Title {
    let romaji: String?
    let english: String?
    let native: String?
}

// Updated mock data with the new structure
var mockAnimeList: [MockAnimeData] = [
    MockAnimeData(
            id: "11061",
            title: Title(romaji: "Trigun", english: "Trigun", native: nil),
            description: "Vash the Stampede is a wanted man with a habit of turning entire towns into rubble. The price on his head is a fortune, and his path of destruction reaches across the arid wastelands of a desert planet. Unfortunately, most encounters with the spiky-haired gunslinger don't end well for the bounty hunters who catch up with him; someone almost always gets hurt - and it's never Vash.\nOddly enough, for such an infamous fugitive, there's no proof that he's ever taken a life. In fact, he's a pacifist with a doughnut obsession who's more doofus than desperado. There's a whole lot more to him than his reputation lets on - Vash the Stampede definitely ain't your typical outlaw. (Source: Funimation)",
            episodes: 148,
            genres: ["Action", "Adventure", "Supernatural"],
            bannerImage: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg",
            coverImage: CoverImage(
                large: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx15125.jpg",
                medium: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx15125.jpg"
            ),
            localCoverImage: "Trigun-Cover", localBannerImage: "Trigun-Banner", isFavorite: false, airing: "Airs in  5 days", remainingDays: 7, image: "romance2.jpg"
        ),
        MockAnimeData(
            id: "16498",
            title: Title(romaji: "Witch Hunter ROBIN", english: "Witch Hunter ROBIN", native: nil),
            description: "Robin Sena is a powerful craft user drafted into the STNJ - a group of specialized hunters that fight deadly beings known as Witches. Though her fire power is great, she’s got a lot to learn about her powers and working with her cool and aloof partner, Amon. But the truth about the Witches and herself will leave Robin on an entirely new path that she never expected!<br>\n<br>\n(Source: Funimation)",
            episodes: 75,
            genres: ["Action", "Drama", "Fantasy"],
            bannerImage: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg",
            coverImage: CoverImage(
                large: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx15125.jpg",
                medium: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx15125.jpg"
            ), localCoverImage: "ROBIN-Cover", localBannerImage: "ROBIN-Banner", isFavorite: false
            , airing: "Airs in 2 hours", remainingDays: 8, image: "lutaverde.jpeg"
        ),
        MockAnimeData(
            id: "20583",
            title: Title(romaji: "Eyeshield 21", english: "Eyeshield 21", native: nil),
            description: "Welcome To the Gridiron of the Damned! Huge hulking bodies throw themselves at each other, while a tiny lithe body runs between them for the goal!  No, its not a game of football, its Sena Kobayakawa trying to evade the monstrous Ha-Ha brothers down the halls of Deimon High School!",
            episodes: 12,
            genres: ["Adventure", "Comedy", "Fantasy"],
            bannerImage: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg",
            coverImage: CoverImage(
                large: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx15125.jpg",
                medium: "https://s4.anilistcdn/media/anime/cover/medium/bx15125.jpg"
            ), localCoverImage: "Eyeshield21-Cover", localBannerImage: "Eyeshield21-Banner", isFavorite: false, airing: "Airs in 24 days", remainingDays: 3, image: "anime2.png"
        ),
        MockAnimeData(
            id: "30276",
            title: Title(romaji: "Honey and Clover", english: "Honey and Clover", native: nil),
            description: "Takemoto Yuuta, Mayama Takumi, and Morita Shinobu are college students who share the small apartment. Even though they live in poverty, the three of them are able to obtain pleasure through small things in life. The story follows these characters' life stories as poor college students, as well as their love lives when a short but talented 18 year old girl called Hanamoto Hagumi appears.(Source: Anime News Network)",
            episodes: 12,
            genres: ["Action", "Comedy", "Supernatural"],
            bannerImage: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg",
            coverImage: CoverImage(
                large: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx15125.jpg",
                medium: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx15125.jpg"
            ), localCoverImage: "HoneyandClover-Cover", localBannerImage: "HoneyandClover-Banner", isFavorite: false, airing: "Airs in 1 hour", remainingDays: 23, image: "anime3.png"
        
        
            )
    
]
