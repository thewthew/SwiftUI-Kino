//
//  Movie.swift
//  MyKino
//
//  Created by Matthew Usdin on 2/26/23.
//

import Foundation

struct MoviesInfo: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let rating: Double
    let releaseDate: String?
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case rating = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

extension Movie {
    var posterFullUrlPath: String {
        "https://image.tmdb.org/t/p/original/\(posterPath)"
    }

    var starNumber: Int {
        switch rating {
        case 0...2.0:
            return 1
        case 2.0...4.0:
            return 2
        case 4.0...6.0:
            return 3
        case 6.0...8.0:
            return 4
        case 8.0...10.0:
            return 5
        default:
            return 0
        }
    }
}
