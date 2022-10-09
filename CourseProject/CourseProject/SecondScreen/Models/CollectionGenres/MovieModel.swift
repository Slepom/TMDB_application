// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - MovieModel
struct MovieModel: Decodable, Hashable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Decodable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)!
//        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)!
//        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS)!
//        id = try values.decodeIfPresent(Int.self, forKey: .id)!
//        let originalLanguage = try values.nestedContainer(keyedBy: OriginalLanguage.self, forKey: .originalLanguage)
//
//    }

}

enum OriginalLanguage: String, Decodable, Hashable {
    case en = "en"
    case es = "es"
    case fr = "fr"
    case ja = "ja"
    
}
//extension OriginalLanguage: CodingKey{
//    
//    
//}
