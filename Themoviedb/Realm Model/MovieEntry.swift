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

    let voteCount = RealmOptional<Int>()
    let id = RealmOptional<Int>()
    let value = RealmOptional<Int>()
    let video = RealmOptional<Bool>()
    let voteAverage = RealmOptional<Double>()
    @objc dynamic var title: String?
    let popularity = RealmOptional<Double>()
    @objc dynamic var posterPath: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var overview: String?
    @objc dynamic var rewritedetailMovieResponce: DetailMovieEntry?

    override static func primaryKey() -> String? {
        return "id"
    }
}
