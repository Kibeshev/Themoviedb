//
//  VideosResponse.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation

struct VideosResponse: Codable {
    let results: [Video]
}
