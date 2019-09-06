//
//  ImageGalleryViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import BusinessUseCases
import Domain

class ImageGalleryViewModel: ViewModel {
    
    var gallery: Gallery = Gallery(images: [])
    
    var didObserveGallery: ((Gallery) -> Void)?
    var didObserveGalleryError: ((Error) -> Void)?
    
    private var dataStorePager: DataStorePager
    private var detailNavigator: ImageDetailNavigator
    
    init(dataStorePager: DataStorePager, detailNavigator: ImageDetailNavigator) {
        self.dataStorePager = dataStorePager
        self.detailNavigator = detailNavigator
    }
 
    func userDidSelectItem(at indexPath: IndexPath, context: UIViewController) {
        let image = gallery.image(at: indexPath.row)
        if let imageUrl = image.url(for: .large) {
            detailNavigator.navigateDetail(of: imageUrl, from: context)
        }
    }
    
    private var lastTag: String?
    
    func fetchNewItems(for tag: String) {
        lastTag = tag
        let tag = tag.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        dataStorePager.searchNewGalleryItems(by: tag) { [weak self] (response) in
            switch response {
            case .success(let gallery):
                self?.gallery = gallery
                self?.didObserveGallery?(gallery)
            case .failure(let error):
                self?.didObserveGalleryError?(error)
            }
        }
    }
    
    func bindCell(_ cell: ImageCollectionViewCell, at indexPath: IndexPath) {
        if let url = gallery.image(at: indexPath.row).url(for: .square) {
            cell.url = url
        }
        
        if indexPath.row == gallery.count - 1, let tag = lastTag {
            fetchNewItems(for: tag)
        }
        
    }
    
}
