//
//  DetailMovieResponse.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation

struct DetailMovie: Codable {
    let originalLanguage: String?
    let budget: Int?
    let revenue: Int?
    let videos: VideosResponse?
    let image: [Poster]?
    let runtime: Int?
}
