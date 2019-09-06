//
//  ImageDetailViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    @IBAction func userDidTapDoneButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 10.0
            scrollView.delegate = self
        }
    }
    
    private let imageUrl: String
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            if let url = URL(string: imageUrl) {
                imageView.kf.setImage(with: url)
            }
        }
    }
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ImageDetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
