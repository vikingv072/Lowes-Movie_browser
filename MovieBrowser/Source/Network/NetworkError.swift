//
//  NetworkError.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/1/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case urlFailure
    case dataFailure
    case statusFailure(Int)
}
