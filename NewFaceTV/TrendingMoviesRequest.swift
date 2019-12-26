//
//  TrendingMoviesRequest.swift
//  NewFaceTV
//
//  Created by David on 2019-20-18.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation


struct MoviesRequest {
         //API url address to call
    private let urlString =  Constants().baseURL+Constants().trendingMovies+Constants().plus+Constants().apiKey
       
    
    func fetchMovieData(completion: @escaping (Result<[Movie], Error>)->Void){
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Error", err)
                return
            }
            
            guard let jsonData = data else {print("Error, no data available"); return}
        
            //If Responso Ok and no Error = Succesfull network data fetching
            
            //Parse jsonData
            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: jsonData)
                
                let movies = moviesResponse.results
                
                 completion(.success(movies))
                
            } catch let jsonErr {
                print("Error", jsonErr)
                completion(.failure(jsonErr))
            }
        }
        dataTask.resume()
    }
}

