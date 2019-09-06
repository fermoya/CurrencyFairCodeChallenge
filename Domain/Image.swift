//
//  Image.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public typealias ImageId = UInt
public typealias ImageCollection = [Image.Size: String]

public struct Image {
    
    public enum Size: String {
        case square = "Square", largeSquare = "Large Square"
        case thumbnail = "Thumbnail"
        case small = "Small", small320 = "Small 320"
        case medium = "Medium", medium640 = "Medium 640", medium800 = "Medium 800"
        case large = "Large", large1600 = "Large 1600", large2048 = "Large 2048"
    }
    
    public var id: ImageId
    public var urls: ImageCollection
    
    public init(id: ImageId, urls: ImageCollection = [:]) {
        self.id = id
        self.urls = urls
    }
    
}
