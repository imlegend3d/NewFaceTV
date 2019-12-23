//
//  TrendingViewController.swift
//  NewFaceTV
//
//  Created by David on 2019-20-13.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listOfMovies = [Movie]() {
        didSet{
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet{
            moviesTableView.delegate = self
            moviesTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the request of data from the api
        MoviesRequest().fetchMovieData { [weak self] (res) in
            
            switch res {
            case .success(let movies):
                self?.listOfMovies = movies.sorted{$0.popularity > $1.popularity}
               
            case . failure(let error):
                print("Failed to fetch data:", error)
            }
        }
        
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 700
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    
        moviesTableView.rowHeight = UITableView.automaticDimension
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
 
}

extension TrendingViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count
     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants().trendingCell , for: indexPath) as! MovieTableViewCell
        let movie = listOfMovies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.setupPosterImage(posterPath: Constants().imageBaseURL+movie.poster_path)
        cell.popularityLabel.text = "Popularity:\(String(movie.popularity))"
        cell.voteAverageLabel.text = "Rating:\(String(movie.vote_average))"
        
        return cell
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.size.width * 1.63) + 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.movie = listOfMovies[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}


