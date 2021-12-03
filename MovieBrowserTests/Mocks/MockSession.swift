//
//  MockSession.swift
//  MovieBrowserTests
//
//  Created by Kevin Varghese on 12/2/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
@testable import MovieBrowser

class MockSession: Session {
    
    func dataRequest(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if url.absoluteString.contains("Success") {
                guard let path = Bundle(for: NetworkManagerTests.self).path(forResource: "MovieData", ofType: "json") else {
                    completion(nil, nil, nil)
                    return
                }
                let url = URL(fileURLWithPath: path)
                let data = try? Data(contentsOf: url)
                completion(data, nil, nil)
            } else {
                completion(nil, nil, NetworkError.dataFailure)
            }
        }
        
    }
    
}
