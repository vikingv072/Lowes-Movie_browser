//
//  Movies.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/1/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct PageResult: Decodable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    var id: Int
    var posterImage: String
    var title: String
    var rating: Double
    var releaseDate: String?
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case rating = "vote_average"
        case posterImage = "poster_path"
    }
}
