//
//  MoviesAPIManager.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation
import UIKit

class MoviesAPIManager {

    func getMovieImages(id: Int, completion: @escaping (GetMovieImagesResponse?) -> Void) {
        let urlString = """
        https://api.themoviedb.org/3/movie/\(
        id
        )/images?api_key=4cb1eeab94f45affe2536f2c684a5c9e&append_to_response&language=en
        """
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let rawResponse = try? decoder.decode(GetMovieImagesResponse.self, from: data) {
                    completion(rawResponse)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }

    func detailGetMovie(urlString: String, completion: @escaping (DetailMovieResponse?) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let rawResponse = try? decoder.decode(DetailMovieResponse.self, from: data) {
                    completion(rawResponse)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }

    func getMovies(urlString: String, completion: @escaping (GetPopularMoviesResponse?) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let rawResponse = try? decoder.decode(GetPopularMoviesResponse.self, from: data) {
                    completion(rawResponse)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }
}
