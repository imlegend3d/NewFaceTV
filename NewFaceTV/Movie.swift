//
//  Movie.swift
//  NewFaceTV
//
//  Created by David on 2019-20-17.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    let poster_path: String
    let title: String
    let popularity: Double
    let id: Int
    let overview: String
    let vote_average: Double
    let backdrop_path: String
    let release_date: String
}
