//
//  ViewController.swift
//  TestingApp
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.tableView.rowHeight = 200
        loadMovies()
    }
    
    private func loadMovies() {
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let search = try decoder.decode(MovieSearch.self, from: data)
                    self.movies = search.results
                } catch {
                    print("Nothing in here")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configureImage(movie: movie)
        return cell
    }
    

}

