//
//  ViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var actitviti: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let imageTap = CellMovies()
    let manager = MoviesAPIManager()
    var movies: [Movie] = []
    
    var pageNext: String = ""
   
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4cb1eeab94f45affe2536f2c684a5c9e"
    
// large title нужно сделать
//    static let largeTitle: UIFont.TextStyle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        actitviti.startAnimating()

        tableView.tableFooterView = UIView()
        
//        tableView.layoutMargins = UIEdgeInsets.zero
//        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.delegate = self
        tableView.dataSource = self
        
        manager.getMovie(urlString: urlString, completion:  { getPopularMoviesResponse in
            DispatchQueue.main.async {
                self.movies = getPopularMoviesResponse?.results ?? []
                if let responsePage = getPopularMoviesResponse?.page {
                    self.pageNext = String(responsePage + 1)
                }
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.actitviti.stopAnimating()
                
            }
        })
            

        // large title похоже сделал 
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Popular"

        // Do any additional setup after loading the view.
      
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = movies.count - 3
        if indexPath.row == lastItemIndex {
            loadMoreMovies()
        }
    }
    func loadMoreMovies(){
        manager.getMovie(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=4cb1eeab94f45affe2536f2c684a5c9e&page=\(pageNext)" ) { (getPopularMoviesResponse) in
            DispatchQueue.main.async {
                self.movies.append(contentsOf: getPopularMoviesResponse?.results ?? [] )
//                self.pageNext = getPopularMoviesResponse?.page
                if let responsePage = getPopularMoviesResponse?.page {
                    self.pageNext = String(responsePage + 1)
                }
//                if getPopularMoviesResponse?.results != nil{
                self.tableView.reloadData()
//                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? CellMovies
        
        let movies = self.movies[indexPath.row]
        cell?.labelTitle.text = movies.original_title
        cell?.labelDescriptions.text = movies.overview
        if let image = movies.poster_path  {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)"), let imageView = cell?.imageMovies {
                Nuke.loadImage(with: imageURL, into: imageView )
            }
        }
     return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let viewTwo = self.events[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? SecondViewController
        self.navigationController?.pushViewController(controller!, animated: true)
        controller?.movies = self.movies[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


