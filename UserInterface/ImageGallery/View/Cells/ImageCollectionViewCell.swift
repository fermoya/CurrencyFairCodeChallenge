//
//  ImageCollectionViewCell.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 5
            thumbnailImageView.layer.masksToBounds = true
        }
    }
    
    var url: String = "" {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let imageUrl = URL(string: url) {
            thumbnailImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
