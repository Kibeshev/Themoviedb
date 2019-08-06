//
//  movieEntry.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 31/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation
import RealmSwift

//class RewriteGetPopularMoviesResponse: Object {
//    @objc dynamic var page = 0
//    @objc dynamic var total_results = 0
//    @objc dynamic var total_pages = 0
//    @objc dynamic var results2: [RewriteMovie]?
//    @objc dynamic var session_id: String?
//}

class RewriteMovie: Object {

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
    @objc dynamic var rewritedetailMovieResponce: RewriteDetailMovieResponse?

    override static func primaryKey() -> String? {
        return "id"
    }
}

class RewriteDetailMovieResponse: Object {

    @objc dynamic var original_language: String?
    @objc dynamic var budget = 0
    @objc dynamic var revenue = 0
//    let videos: VideosResponse?
//    let image: [Posters]?
    @objc dynamic var runtime = 0
}
