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
}
