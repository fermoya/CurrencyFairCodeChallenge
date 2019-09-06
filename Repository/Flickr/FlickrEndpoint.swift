//
//  FlickrEndpoint.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

enum FlickrEndpoint {
    case searchTag(tag: String, page: UInt, apiKey: String)
    case imageDetail(id: UInt, apiKey: String)
    
    private var host: String { return "https://api.flickr.com" }
    private var path: String { return "/services/rest" }
    private var method: String {
        switch self {
        case .searchTag:
            return "flickr.photos.search"
        case .imageDetail:
            return "flickr.photos.getSizes"
        }
    }
    
    private var queryItems: String {
        switch self {
        case .searchTag(let tag, let page, let apiKey):
            return "?method=\(method)&api_key=\(apiKey)&tags=\(tag)&page=\(page)&format=json&nojsoncallback=1"
        case .imageDetail(let imageId, let apiKey):
            return "?method=\(method)&api_key=\(apiKey)&photo_id=\(imageId)&format=json&nojsoncallback=1"
        }
    }
    
    var url: String {
        return host + path + queryItems
    }
}
