//
//  DetailMovieEntry.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 16.01.2020.
//  Copyright © 2020 Кирилл Кибешев. All rights reserved.
//

import Foundation
import RealmSwift

class DetailMovieEntry: Object {

    @objc dynamic var originalLanguage: String?
    var budget = RealmOptional<Int>()
    var revenue = RealmOptional<Int>()
    var runtime = RealmOptional<Int>()
}
