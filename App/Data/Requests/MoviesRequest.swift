//
//  MoviesRequest.swift
//  Base
//
//  Created by Victor Catão on 31/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class MoviesRequest {
    
    static func getGenreList() -> Observable<ListGenre> {
        return RequestManager.getToAPIService(endpoint: .genreList)
    }
    
    static func getPopular() -> Observable<ListMovies> {
        return RequestManager.getToAPIService(endpoint: .popular)
    }
    
    static func getTopRated() -> Observable<ListMovies> {
        return RequestManager.getToAPIService(endpoint: .topRated)
    }
    
    static func getSimilar(movieId: Int) -> Observable<ListMovies> {
        let url = String(format: Endpoint.similar.value, String(movieId))
        return RequestManager.getToAPIService(endpoint: .similar, customURL: "\(API_URL)\(url)")
    }
    
    static func getReviews(movieId: Int) -> Observable<ListReview> {
        let url = String(format: Endpoint.reviews.value, String(movieId))
        return RequestManager.getToAPIService(endpoint: .reviews, customURL: "\(API_URL)\(url)")
    }
    
    static func getMovieDetail(movieId: Int) -> Observable<Movie> {
        let url = String(format: Endpoint.movieDetail.value, String(movieId))
        return RequestManager.getToAPIService(endpoint: .movieDetail, customURL: "\(API_URL)\(url)")
    }
    
    static func getMoviesForGenre(genreId: Int) -> Observable<ListMovies> {
        var params = Parameters()
        params["with_genres"] = genreId
        return RequestManager.getToAPIService(endpoint: .moviesForGenre, parameters: params)
    }
    
}
