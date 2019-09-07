//
//  ImageGalleryViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Domain

class ImageGalleryViewController: UIViewController, Bindable {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.stopAnimating()
        }
    }
    @IBOutlet weak var emptyStateView: EmptyStateView! {
        didSet {
            emptyStateView.isHidden = true
        }
    }
    
    @IBOutlet weak var galleryCollectionView: UICollectionView! {
        didSet {
            galleryCollectionView.dataSource = self
            galleryCollectionView.delegate = self
            galleryCollectionView.register(UINib(nibName: ImageCollectionViewCell.className,
                                                 bundle: Bundle(for: type(of: self))),
                                           forCellWithReuseIdentifier: ImageCollectionViewCell.className)
        }
    }
    
    private var tag: String! {
        didSet {
            activityIndicator.startAnimating()
            emptyStateView.isHidden = true
            viewModel.fetchNewItems(for: tag)
        }
    }
    
    private var gallery: Gallery {
        get { return viewModel.gallery }
        set { viewModel.gallery = newValue }
    }
    
    let viewModel: ImageGalleryViewModel
    
    init(viewModel: ImageGalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.didObserveGallery = { [weak self] gallery in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.gallery = gallery
            self.emptyStateView.isHidden = true
            self.galleryCollectionView.reloadData()
        }
        
        viewModel.didObserveGalleryError = { [weak self] error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.emptyStateView.isHidden = false
            self.emptyStateView.text = error.localizedDescription
        }
        
        weak var weakSelf = self
        viewModel.didObserveImageError = weakSelf?.showErrorAlert
        
        emptyStateView.didTap = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.startAnimating()
            self.viewModel.fetchNewItems(for: self.tag)
        }
    }

}

extension ImageGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let size = (screenWidth - 10) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userDidSelectItem(at: indexPath, context: self)
    }
    
}

extension ImageGalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as! ImageCollectionViewCell
        viewModel.bindCell(cell, at: indexPath)
        
        return cell
    }
    
}

extension ImageGalleryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.tag = text
        }
        searchBar.resignFirstResponder()
    }
    
}
