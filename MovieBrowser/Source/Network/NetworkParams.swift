//
//  NetworkParams.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/1/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum NetworkParams {
    
    private enum NetworkBase: String {
        case baseSearch = "https://api.themoviedb.org/3/search/movie"
        case baseImage = "https://image.tmdb.org/t/p/w500"
        case apiKey = "5885c445eab51c7004916b9c0313e2d3"
    }
    
    case searchRequest(String)
    case imageRequest(String)
    
    var url: URL? {
        switch self {
        case .searchRequest(let query):
            var components = URLComponents(string: NetworkBase.baseSearch.rawValue)
            components?.queryItems = [URLQueryItem(name: "api_key", value: NetworkBase.apiKey.rawValue), URLQueryItem(name: "query", value: query)]
            return components?.url
        case .imageRequest(let path):
            return URL(string: NetworkBase.baseImage.rawValue + path)
//            let baseURL = URL(string: NetworkBase.baseImage.rawValue)
//            return URL(string: path, relativeTo: baseURL)
        }
        
    }
    
    
}
