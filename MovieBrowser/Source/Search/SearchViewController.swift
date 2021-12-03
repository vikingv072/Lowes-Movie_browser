//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
            
    static func createViewController() -> SearchViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SearchViewController.self)") as? SearchViewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTable: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieTable.reloadData()
            }
        }
    }
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Search"
        self.movieTable.dataSource = self
        self.movieTable.delegate = self
        self.movieTable.register(MovieTableViewCell.self, forCellReuseIdentifier: "\(MovieTableViewCell.self)")
    }
    
    @IBAction func search(_ sender: Any) {
                 
        guard let text = self.searchBar.text, !text.isEmpty else { return }
        
        self.networkManager.getModel(url: NetworkParams.searchRequest(text).url) { [weak self] (result: Result<PageResult, Error>) in
            switch result {
            case .success(let page):
                self?.movies = page.results
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(movie: self.movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = MovieDetailViewController.createViewController() else { return }
        detailVC.configure(movie: self.movies[indexPath.row], networkManager: self.networkManager)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
