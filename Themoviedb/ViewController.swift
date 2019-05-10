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
 
    @IBOutlet weak var tableView: UITableView!
    
    let manager = MoviesAPIManager()
    var movies: [Movie] = []
    
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4cb1eeab94f45affe2536f2c684a5c9e"
// large title нужно сделать
//    static let largeTitle: UIFont.TextStyle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
//        tableView.layoutMargins = UIEdgeInsets.zero
//        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.delegate = self
        tableView.dataSource = self
        
        manager.getMovie(urlString: urlString, completion:  { getPopularMoviesResponse in
            DispatchQueue.main.async {
                self.movies = getPopularMoviesResponse?.results ?? []
                self.tableView.reloadData()
            
            }
        })
            

        // large title похоже сделал 
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.blue,
             NSAttributedString.Key.font: UIFont(name: "Papyrus", size: 30) ??
                UIFont.systemFont(ofSize: 30)]
        title = "Popular"

        // Do any additional setup after loading the view.
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
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


}


