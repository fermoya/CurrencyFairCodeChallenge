//
//  ImageWrapper.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

struct SizesWrapper: Decodable {
    var sizes: Sizes
}

struct Sizes: Decodable {
    var size: [Size]
}

struct Size: Decodable {
    var label: String
    var source: String
}

extension SizesWrapper {
    
    var imageCollection: ImageCollection {
        let imagesSizes = sizes.size
            .map { (Image.Size(rawValue: $0.label), $0.source) }
            .filter { $0.0 != nil }
            .map { ($0.0!, $0.1) }.reduce(ImageCollection.init()) { collection, newEntry in
                var newCollection = collection
                newCollection[newEntry.0] = newEntry.1
                return newCollection
            }
        return imagesSizes
    }
    
}
