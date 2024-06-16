

import Foundation

struct Film: Decodable {
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }
    
    static var example: Film {
        return Film(
            title: "First film", episodeID: -1, openingCrawl: "Example film", director: "Hiberus", producer: "", releaseDate: "", characters: ["Yoda", "Han Solo"], planets: ["Hoth", "Naboo"], starships: [], vehicles: [], species: [], created: "", edited: "", url: ""
        )
    }
}
