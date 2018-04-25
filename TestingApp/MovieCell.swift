//
//  MovieCell.swift
//  TestingApp
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var moveImageView: UIImageView!
    
    func configureImage(movie: Movie) {
        moveImageView.image = nil
        ImageHelper.manager.getImage(from: movie.artworkUrl100, completionHandler: {self.moveImageView.image = $0}, errorHandler: {print($0)})
    }

}
