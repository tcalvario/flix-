//
//  PhotosViewController.swift
//  Flix
//
//  Created by Teodoro Calvario on 2/6/19.
//  Copyright © 2019 Teodoro Calvario. All rights reserved.
//

import UIKit

import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var movieTable: UITableView!
    
    
    var movies: [[String: Any]] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       movieTable.delegate = self
       movieTable.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
               
                // TODO: Get the array of movies
                self.movies = dataDictionary["results"] as! [[String:Any]]
      

                // TODO: Reload your table view data
              
                  print(dataDictionary)
            }
             self.movieTable.reloadData()
        }
        task.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! movieCell
      
       let movie = movies[indexPath.row]
       let title = movie["title"] as! String
       let synopsis = movie["overview"] as! String
 
    cell.movieTitle.text = title
    cell.movieSynopsis.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.movieImages.af_setImage(withURL: posterUrl!)
 
       
        
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
        //find the selected movie
        
        let cell = sender as! UITableViewCell
        let indexPath = movieTable.indexPath(for:
            cell)!
        
        let movie = movies[indexPath.row]
        
        //pass the eelected movie to the details view controller
        
        let detailsViewController = segue.destination as! MovieDetailViewController
        
        detailsViewController.movie = movie
        movieTable.deselectRow(at: indexPath, animated: true)
        
        print("loading up screen details")
        
    }
    
}
