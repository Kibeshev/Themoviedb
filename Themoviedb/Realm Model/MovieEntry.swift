//
//  MovieEntry.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 31/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation
import RealmSwift

class MovieEntry: Object {

    let vote_count = RealmOptional<Int>()
    let id = RealmOptional<Int>()
    let value = RealmOptional<Int>()
    let video = RealmOptional<Bool>()
    let vote_average = RealmOptional<Double>()
    @objc dynamic var title: String?
    let popularity = RealmOptional<Double>()
    @objc dynamic var poster_path: String?
    @objc dynamic var original_language: String?
    @objc dynamic var original_title: String?
    @objc dynamic var overview: String?
    @objc dynamic var rewritedetailMovieResponce: DetailMovieEntry?

    override static func primaryKey() -> String? {
        return "id"
    }
}
