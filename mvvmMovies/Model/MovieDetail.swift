//
//  MovieDetail.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
    }

    init(id: Int, title: String, overview: String, backdropPath: String, posterPath: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
}
