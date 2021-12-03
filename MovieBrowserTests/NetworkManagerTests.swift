//
//  NetworkManagerTests.swift
//  MovieBrowserTests
//
//  Created by Kevin Varghese on 12/2/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockSession())
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }

    func testGetModelSuccess() {
        let expectation = XCTestExpectation(description: "Successfully got data")
        var movies: [Movie]?
        
        self.networkManager.getModel(url: URL(string: "https://Success.org")) { (result: Result<PageResult, Error>) in
            switch result {
            case .success(let page):
                movies = page.results
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssertEqual(movies?.count, 20)
        XCTAssertEqual(movies?.first?.title, "Star Trek")
        XCTAssertEqual(movies?.first?.releaseDate, "2009-05-06")
        XCTAssertEqual(movies?.first?.rating, 7.4)
        XCTAssertEqual(movies?.first?.overview, "The fate of the galaxy rests in the hands of bitter rivals. One, James Kirk, is a delinquent, thrill-seeking Iowa farm boy. The other, Spock, a Vulcan, was raised in a logic-based society that rejects all emotion. As fiery instinct clashes with calm reason, their unlikely but powerful partnership is the only thing capable of leading their crew through unimaginable danger, boldly going where no one has gone before. The human adventure has begun again.")
        
    }
    
    func testGetModelFail() {
        let expectation = XCTestExpectation(description: "Failed to get data")
        var err: NetworkError?
        
        self.networkManager.getModel(url: URL(string: "https://Fail.org")) { (result: Result<PageResult, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                err = error as? NetworkError
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssertEqual(err, NetworkError.dataFailure)
    }

}
