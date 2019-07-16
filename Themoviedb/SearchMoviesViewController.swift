//
//  SearchMoviesViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController {

    var moviesViewController: MoviesViewController?
    @IBOutlet private weak var tableView: UITableView?
    var searchArray: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        let searchViewController = UISearchController(searchResultsController: moviesViewController)
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    }
}

extension SearchMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
}

extension SearchMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TestCellSearch", for: indexPath
            ) as? SearchMoviesTableViewCell
        return cell ?? UITableViewCell()

    }
}
