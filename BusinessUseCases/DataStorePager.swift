//
//  DataStorePager.swift
//  BusinessUseCases
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository
import Domain

public typealias SearchGalleryResponse = Result<Gallery, DataStoreError>

public class DataStorePager {
    
    private let dataStore: DataStore
    private var page: UInt = 1
    private var gallery: Gallery = Gallery(images: [])
    private var isPagingEnabled = true
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    public func searchNewGalleryItems(by tag: String, completion: @escaping (SearchGalleryResponse) -> Void) {
        guard isPagingEnabled else { return completion(.success(gallery)) }
        
        dataStore.searchGallery(by: tag, page: page) { [weak self] (result) in
            guard let self = self else { return }
            guard let newPage = try? result.get() else {
                self.isPagingEnabled = false
                return completion(result.map { $0.gallery })
            }
            self.isPagingEnabled = self.page < newPage.totalPages
            self.gallery.images.append(contentsOf: newPage.gallery.images)
            self.page += 1
            completion(.success(self.gallery))
        }
        
    }
    
    
}
