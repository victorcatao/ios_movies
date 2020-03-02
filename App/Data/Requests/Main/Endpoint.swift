//
//  Endpoint.swift
//  Victor Catao
//
//  Created by Victor Catao on 06/06/19.
//  Copyright © 2019 Victor Catao. All rights reserved.
//

#if Movies || MoviesKids
    let API_URL = "https://api.themoviedb.org/3/"
#elseif HmgDebug || HmgRelease
    let API_URL = "https://api.themoviedb.org/3/"
#elseif DevDebug || DevRelease
    let API_URL = "https://api.themoviedb.org/3/"
#endif

// Enum of the endpoints used by the app.
// All the endpoints used in the requests must be added here
enum Endpoint: String {
    
    case genreList      = "genre/movie/list"
    case popular        = "movie/popular"
    case topRated       = "movie/top_rated"
    case similar        = "movie/%@/similar"
    case movieDetail    = "movie/%@"
    case moviesForGenre = "discover/movie"
    case reviews        = "movie/%@/reviews"
    
    var value: String {
        get { return self.rawValue }
    }
}
