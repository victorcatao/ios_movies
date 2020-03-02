//
//  MoviesTestsApp.swift
//  MoviesTestsApp
//
//  Created by Victor Catão on 02/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTestsApp: XCTestCase {

    private var nilMovie: Movie?
    private var emptyMovie = Movie()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        nilMovie = nil
        emptyMovie = Movie()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test if the is doing the correct conversion from yyyy-dd-MM to dd/MM/yyyy
    func testReleaseDateConversion() {
        let movie = Movie(release_date: "2018-08-22")
        XCTAssertTrue(movie.releaseDateConvertedToBrazilianFormat() == "22/08/2018")
        XCTAssertFalse(movie.releaseDateConvertedToBrazilianFormat() == "08/22/2018")
    }
    
    /// Test if the movie is only for adults. Useful for kid's target
    func testMovieAdult() {
        let adultMovie = Movie(adult: true)
        XCTAssertTrue(adultMovie.isMovieAdult())
        
        let notAdultMovie = Movie(adult: false)
        XCTAssertFalse(notAdultMovie.isMovieAdult())
        
        XCTAssertFalse(emptyMovie.isMovieAdult())
    }

    /// Test the conversion to dollar
    func testDollarConversion() {
        let movie = Movie(budget: 1000)
        XCTAssertTrue(movie.budget!.toDollar == "$1,000.00")
        XCTAssertFalse(movie.budget!.toDollar == "$ 1,000.00")
        XCTAssertFalse(movie.budget!.toDollar == "$1.000,00")
    }
    
    /// Test the mapping: Name protocol's array to string, separeted by break lines
    func testMapNameArray() {
        let str1 = "Test 1"
        let str2 = "Test 2"
        
        let genre1 = Genre(name: str1)
        let genre2 = Genre(name: str2)
        
        let movie = Movie(genres: [genre1, genre2])
        XCTAssertTrue(movie.mapNameArrayProtocol(movie.genres) == "\(str1)\n\(str2)")
    }
    
    /// Test cleaning adult movies from array for kid's Target. The function clearAdultMoviesFromCollection must change the parameter
    func testCleaningAdultMoviesFromArrayForKids() {
        let homeViewModel = HomeViewModel()
        
        let adultMovie = Movie(adult: true)
        
        var movies = [emptyMovie, adultMovie]
        homeViewModel.clearAdultMoviesFromCollection(movies: &movies)
        
        XCTAssert(movies.count == 1) // adultMovie should be deleted
    }
    
}

