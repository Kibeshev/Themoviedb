//
//  Movie.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let vote_count: Int?
    let id: Int?
    let video: Bool
    let vote_average: Double?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let detailMovieResponce: DetailMovieResponse?
}
