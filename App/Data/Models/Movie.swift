//
//  self.swift
//  Base
//
//  Created by Victor Catão on 31/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var production_companies: [Company]?
    var production_countries: [Country]?
    var spoken_languages: [Language]?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var release_date: String?
    var poster_path: String?
    var vote_average: Float?
    var popularity: Float?
    var homepage: String?
    var genre_ids: [Int]?
    var overview: String?
    var vote_count: Int?
    var genres: [Genre]?
    var tagline: String?
    var revenue: Float?
    var status: String?
    var budget: Float?
    var title: String?
    var video: Bool?
    var adult: Bool?
    var id: Int?
    
    init(production_companies: [Company]? = nil, production_countries: [Country]? = nil, spoken_languages: [Language]? = nil, original_language: String? = nil, original_title: String? = nil, backdrop_path: String? = nil, release_date: String? = nil, poster_path: String? = nil, vote_average: Float? = nil, popularity: Float? = nil, homepage: String? = nil, genre_ids: [Int]? = nil, overview: String? = nil, vote_count: Int? = nil, genres: [Genre]? = nil, tagline: String? = nil, revenue: Float? = nil, status: String? = nil, budget: Float? = nil, title: String? = nil, video: Bool? = nil, adult: Bool? = nil,
         id: Int? = nil){
        self.production_companies = production_companies
        self.production_countries = production_countries
        self.spoken_languages = spoken_languages
        self.original_language = original_language
        self.original_title = original_title
        self.backdrop_path = backdrop_path
        self.release_date = release_date
        self.poster_path = poster_path
        self.vote_average = vote_average
        self.popularity = popularity
        self.homepage = homepage
        self.genre_ids = genre_ids
        self.overview = overview
        self.vote_count = vote_count
        self.genres = genres
        self.tagline = tagline
        self.revenue = revenue
        self.status = status
        self.budget = budget
        self.title = title
        self.video = video
        self.adult = adult
        self.id = id
    }
    
    
}

extension Movie {
    func getOverview() -> (title: String, informations: [String?: String]) {
        return ("about_movie".localized, [nil: self.overview ?? ""])
    }
    
    func getInformation() -> (title: String, informations: [String: String]) {
        var dic: [String: String] = [:]
        dic["original_title".localized] = self.original_title
        dic["tagline".localized] = self.tagline
        dic["budget".localized] = self.budget?.toDollar
        dic["genres".localized] = self.mapNameArrayProtocol(genres)
        dic["popularity".localized] = String(self.popularity?.toInt ?? 0)
        dic["production_companies".localized] = self.mapNameArrayProtocol(production_companies)
        dic["production_countries".localized] = self.mapNameArrayProtocol(production_countries)
        dic["release_date".localized] = self.releaseDateConvertedToBrazilianFormat()
        dic["spoken_languages".localized] = self.mapNameArrayProtocol(spoken_languages)
        dic["revenue".localized] = self.revenue?.toDollar
        return ("informations".localized, dic)
    }
    
    func releaseDateConvertedToBrazilianFormat() -> String? {
        // original format: yyyy-MM-dd
        guard let originalDateString = release_date else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let originalDate = dateFormatter.date(from: originalDateString) else { return nil }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: originalDate)
    }
    
    func isMovieAdult() -> Bool {
        return adult == true
    }
    
    func mapNameArrayProtocol(_ array: [Name]?) -> String? {
        guard let array = array else { return nil }
        guard array.count > 0 else { return nil }
        return array.map({$0.name ?? ""}).joined(separator: "\n")
    }
    
}
