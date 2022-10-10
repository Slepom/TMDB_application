
import Foundation


struct GenreModel: Codable, Hashable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable, Hashable {
    let id: Int
    let name: String
}


