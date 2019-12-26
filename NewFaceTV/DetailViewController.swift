//
//  DetailViewController.swift
//  NewFaceTV
//
//  Created by David on 2019-12-22.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController {
    
    let c = Constants()
    
    var movie: Movie?
    
    private let backDrop: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.black
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.numberOfLines = Constants().zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twentyEight))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.numberOfLines = Constants().zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twentyFive))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    private let ratingStars: CosmosView = {
        let view = CosmosView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // function to be modified, for now it is needed to comply with the creation of the play UIBarButtonItem.
   var pauseUnpause = true
    
    @objc private func playTapped(){
       pauseUnpause = !pauseUnpause
        let navigation = navigationController
        let bar = navigation!.navigationBar
        bar.setNeedsLayout()
        bar.layoutIfNeeded()
        bar.setNeedsDisplay()
        setPlayButton()
    }
    
     //sets the play movie button
    func setPlayButton(){
        let playPause = pauseUnpause ? UIBarButtonItem.SystemItem.play : UIBarButtonItem.SystemItem.pause
        let play = UIBarButtonItem(barButtonSystemItem: playPause , target: self, action: #selector(playTapped))
           
        navigationItem.rightBarButtonItem = play
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.2
        setupViews()
        setPlayButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        //Sets navigation bar view to appear but clear
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
     }
    
    private func setupViews(){
        //Adds all the views to the screen
        [backDrop, separatorView, movieTitle, ratingView, movieDescription].forEach{view.addSubview($0)}
        
        //sets up all the autolayout of the views.
        backDrop.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: (view.frame.size.width), height: (view.frame.size.height/3)))
        
        separatorView.anchor(top: backDrop.bottomAnchor, leading: backDrop.leadingAnchor, bottom: nil, trailing: backDrop.trailingAnchor, size: .init(width: backDrop.frame.size.width, height: view.frame.size.height/30))
        
        movieTitle.anchor(top: separatorView.bottomAnchor, leading: separatorView.leadingAnchor, bottom: nil, trailing: separatorView.trailingAnchor, size:  .init(width: backDrop.frame.size.width, height: view.frame.size.height/15))
        
        ratingView.anchor(top: movieTitle.bottomAnchor, leading: movieTitle.leadingAnchor, bottom: nil, trailing: movieTitle.trailingAnchor, size: .init(width: backDrop.frame.size.width, height: view.frame.size.height/15))
        
        movieDescription.anchor(top: ratingView.bottomAnchor , leading: ratingView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: ratingView.trailingAnchor)
        
        //loads the picture on the UIImageView
        if let backDropPath = movie?.backdrop_path{
            if let url =  URL(string:c.imageBaseURL + backDropPath){
                backDrop.loadImage(from:url)
            }
        }
        
        //loads the title
        if let title = movie?.title {
            movieTitle.text = title
        }
        
        //loads ratingStars in ratingView
        if let rating = movie?.vote_average {
            ratingView.addSubview(ratingStars)
            
            ratingStars.rating = (rating/2)
            ratingStars.text = String(rating)
            ratingStars.settings.updateOnTouch = false
            ratingStars.settings.fillMode = .precise
            ratingStars.settings.filledBorderColor = UIColor.red
            ratingStars.settings.filledColor = UIColor.yellow
            ratingStars.settings.starSize = Double(c.forty)
            ratingStars.settings.starMargin = Double(c.ten)
            ratingStars.settings.textColor = UIColor.white
            ratingStars.settings.textFont = UIFont.systemFont(ofSize: CGFloat(c.twenty))
            ratingStars.settings.emptyBorderColor = UIColor.yellow
            ratingStars.anchor(top: ratingView.topAnchor, leading: ratingView.leadingAnchor, bottom: ratingView.bottomAnchor, trailing: ratingView.trailingAnchor, padding: .init(top: CGFloat(c.zero), left: (view.frame.size.width/2) - (ratingStars.frame.size.width/2) , bottom: 0, right: 0))
            
        }
        
        //loads description
        if let description = movie?.overview {
            movieDescription.text = description
        }
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
