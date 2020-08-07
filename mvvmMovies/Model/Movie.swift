//
//  Movie.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation

struct MovieList: Decodable, Hashable {
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var list: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case list = "results"
    }
}

struct Movie: Decodable, Hashable {
    var id: Int
    var title: String
    var popularity: Double
    var voteAverage: Double
    var posterPath: String
    var backdropPath: String
    var releaseDate: String
    var releaseDateFormatter: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case popularity = "popularity"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case releasedateFormatter
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        releaseDateFormatter = try values.decodeIfPresent(String.self, forKey: .releasedateFormatter) ?? ""
        releaseDateFormatter = self.dateFormatter(date: releaseDate)
    }
    
}
