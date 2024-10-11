//
//  AnimeMockedData.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 10/10/24.
//

import Foundation

// Mock structure based on the GraphQL response
struct MockAnimeData {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let description: String
    let episodes: Int
}

// Multiple mocked anime data for testing
let mockAnimeList: [MockAnimeData] = [
    MockAnimeData(
        id: 15125,
        titleRomaji: "Sword Art Online",
        titleEnglish: "Sword Art Online",
        description: "In the year 2022, virtual reality has progressed by leaps and bounds, and a massive online role-playing game called Sword Art Online (SAO) is launched.",
        episodes: 25
    ),
    MockAnimeData(
        id: 11061,
        titleRomaji: "Hunter x Hunter",
        titleEnglish: "Hunter x Hunter",
        description: "Gon Freecss aspires to become a Hunter, an exceptional being capable of greatness. With his friends and his potential, he seeks for his father who left him when he was younger.",
        episodes: 148
    ),
    MockAnimeData(
        id: 16498,
        titleRomaji: "Shingeki no Kyojin",
        titleEnglish: "Attack on Titan",
        description: "After his hometown is destroyed and his mother is killed, young Eren Yeager vows to cleanse the earth of the giant humanoid Titans that have brought humanity to the brink of extinction.",
        episodes: 75
    ),
    MockAnimeData(
        id: 20583,
        titleRomaji: "No Game No Life",
        titleEnglish: "No Game No Life",
        description: "Sora and Shiro, two siblings who are notorious in the online gaming world, find themselves in a world where everything is decided by games.",
        episodes: 12
    ),
    MockAnimeData(
        id: 30276,
        titleRomaji: "One Punch Man",
        titleEnglish: "One Punch Man",
        description: "The seemingly ordinary and unimpressive Saitama has a rather unique hobby: being a hero. He does it just for fun, but his strength is too powerful to handle.",
        episodes: 12
    )
]

