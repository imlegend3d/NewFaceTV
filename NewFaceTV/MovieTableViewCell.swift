//
//  MovieTableViewCell.swift
//  NewFaceTV
//
//  Created by David on 2019-20-18.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: CustomImageView! {
        didSet{
            posterImage.layer.cornerRadius = 45
            posterImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var imageCache = NSCache<AnyObject, UIImage>()
    
    func setupPosterImage(posterPath: String){
        if let url = URL(string: posterPath){
            posterImage.loadImage(from: url)
        }
    }
}



