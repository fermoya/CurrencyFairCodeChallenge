//
//  GalleryWrapper.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

struct Id: Decodable {
    var id: String
}

struct PhotosWrapper: Decodable {
    var photos: Photos
}

struct Photos: Decodable {
    var photo: [Id]
    var page: UInt
    var pages: UInt
}

extension PhotosWrapper {
    
    var gallery: Gallery {
        let photoIds = photos.photo.map { UInt($0.id)! }
        let images = photoIds.map { Image(id: $0) }
        return Gallery(images: images)
    }
    
}
