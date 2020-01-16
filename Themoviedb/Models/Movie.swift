//
//  Movie.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let voteCount: Int?
    let id: Int?
    let video: Bool
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let detailMovieResponce: DetailMovieResponse?
}
