//
//  DetailViewController.swift
//  NewFaceTV
//
//  Created by David on 2019-12-22.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie?
    
    let backDrop: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.black
        return imageView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let rating: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let movieButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
        print(movie!)
        setupViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         navigationController?.setNavigationBarHidden(false, animated: animated)
     }
    
    private func setupViews(){
        //Adds all the views to the screen
        [backDrop, separatorView, movieTitle, rating, movieDescription, movieButton].forEach{view.addSubview($0)}
        
        //sets up all the autolayout of the views.
        backDrop.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: (view.frame.size.width), height: (view.frame.size.height/3)))
        
        separatorView.anchor(top: backDrop.bottomAnchor, leading: backDrop.leadingAnchor, bottom: nil, trailing: backDrop.trailingAnchor, size: .init(width: backDrop.frame.size.width, height: view.frame.size.height/30))
        
        movieTitle.anchor(top: separatorView.bottomAnchor, leading: separatorView.leadingAnchor, bottom: nil, trailing: separatorView.trailingAnchor, size:  .init(width: backDrop.frame.size.width, height: view.frame.size.height/15))
        
        rating.anchor(top: movieTitle.bottomAnchor, leading: movieTitle.leadingAnchor, bottom: nil, trailing: movieTitle.trailingAnchor, size: .init(width: backDrop.frame.size.width, height: view.frame.size.height/15))
        
        movieDescription.anchor(top: rating.bottomAnchor , leading: rating.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: rating.trailingAnchor)
        
        //loads the picture on the UIImageView
        if let backDropPath = movie?.backdrop_path{
            if let url =  URL(string:Constants().imageBaseURL + backDropPath){
                backDrop.loadImage(from:url)
            }
        }
        
        //loads the title
        if let title = movie?.title {
            movieTitle.text = title
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
