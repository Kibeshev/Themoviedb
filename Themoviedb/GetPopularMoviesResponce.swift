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
    let total_results: Int?
    let total_pages: Int?
    let results: [Movie]?
    let session_id: String?
}
