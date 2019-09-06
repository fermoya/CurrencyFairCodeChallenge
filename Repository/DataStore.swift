//
//  DataStore.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

public enum DataStoreError: Error, Equatable {
    case unknown(String)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case unavailable
    case noInternetConnection
}

public typealias SearchGalleryResponse = Result<Gallery, DataStoreError>
public typealias ImageDetailResponse = Result<Image, DataStoreError>

public protocol DataStore {
    func searchGallery(by tag: String, page: UInt, completion: @escaping (SearchGalleryResponse) -> Void)
    func searchImageDetail(id: ImageId, completion: @escaping (ImageDetailResponse) -> Void)
}
