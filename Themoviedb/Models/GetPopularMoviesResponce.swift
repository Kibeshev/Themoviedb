//
//  GetPopularMoviesResponce.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation

struct GetPopularMoviesResponse: Codable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]?
    let sessionId: String?
}
