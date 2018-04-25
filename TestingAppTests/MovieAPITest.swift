//
//  MovieAPITest.swift
//  TestingAppTests
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import XCTest
@testable import TestingApp

class MovieAPITest: XCTestCase {
    
    func testMovieAPI() {
        let exp = expectation(description: "Movie results received")
        var movieCount = 0
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let search = try decoder.decode(MovieSearch.self, from: data)
                    movieCount = search.results.count
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        
        //Async call so we need to have timeout
        wait(for: [exp], timeout: 10.0)
        
        XCTAssertGreaterThan(movieCount, 0, "movie count should be greater than 0")
    }
    
    func testUnratedMovies() {
        let exp = expectation(description: "Unrated results received")
        var unratedMovieCount = 0
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    var movies = [Movie]()
                    let decoder = JSONDecoder()
                    let search = try decoder.decode(MovieSearch.self, from: data)
                    movies = search.results
                    movies = movies.filter{$0.contentAdvisoryRating == "Unrated"}
                    unratedMovieCount = movies.count
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        
        //Async call so we need to have timeout
        wait(for: [exp], timeout: 10.0)
        
        XCTAssertEqual(unratedMovieCount, 41, "")
    }
    
    
}
