//
//  MovieTrailer.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 26/04/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MovieTrailer: Decodable {
    let id: Int
    let results: [MovieTrailerKey]
}

// MARK: - Result
struct MovieTrailerKey: Decodable {
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case key
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key) ?? ""
    }
}
