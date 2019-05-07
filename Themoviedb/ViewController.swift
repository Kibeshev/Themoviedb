//
//  ViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let manager = MoviesAPIManager()
    var movies: [Movie] = []
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4cb1eeab94f45affe2536f2c684a5c9e"


    override func viewDidLoad() {
        super.viewDidLoad()
        manager.getMovie(urlString: urlString) { (getPopularMoviesResponse) in
            DispatchQueue.main.async {
                print(getPopularMoviesResponse)
            }
        }

        // Do any additional setup after loading the view.
    }


}

