//
//  movieEntry.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 31/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDatabaseModel: Object {

    @objc dynamic var vote_count = 0
    @objc dynamic var id = 0
    @objc dynamic var video = false
    @objc dynamic var vote_average = 0.0
    @objc dynamic var title: String?
    @objc dynamic var popularity = 0.0
    @objc dynamic var poster_path: String?
    @objc dynamic var original_language: String?
    @objc dynamic var original_title: String?
    @objc dynamic var overview: String?
    @objc dynamic var rewritedetailMovieResponce: DetailMovieResponseDatabaseModel?

    override static func primaryKey() -> String? {
        return "id"
    }
}

class DetailMovieResponseDatabaseModel: Object {

    @objc dynamic var original_language: String?
    @objc dynamic var budget = 0
    @objc dynamic var revenue = 0
    @objc dynamic var runtime = 0
}
