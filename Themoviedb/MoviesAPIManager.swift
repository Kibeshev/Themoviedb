//
//  MoviesAPIManager.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import Foundation
import UIKit

 struct GetPopularMoviesResponse: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Movie]?
    let session_id: String?
}
 struct Movie: Codable {
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Double?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let detailMovieResponce: DetailMovieResponse?
    
}
struct DetailMovieResponse: Codable {
    let original_language: String?
    let budget: Int?
    let revenue: Int?
    let videos: VideosResponse?
    let image: [Posters]?
    let runtime: Int?
    
}
struct GetMovieImagesResponse: Codable {
    let posters: [Posters]
}
struct Posters: Codable {
    let file_path: String?
    let aspect_ratio: Double?
}
struct VideosResponse: Codable {
    let results: [Video]
}
struct Video: Codable {
    let key: String?
}

class MoviesAPIManager {
    
    func getMovieImages(id: Int, completion: @escaping (GetMovieImagesResponse?) -> Void) {
         let urlString = "https://api.themoviedb.org/3/movie/\(id)/images?api_key=4cb1eeab94f45affe2536f2c684a5c9e&append_to_response&language=en"
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
    
    
    
    func getMovie(urlString: String, completion: @escaping (GetPopularMoviesResponse?) -> Void) {
        
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
