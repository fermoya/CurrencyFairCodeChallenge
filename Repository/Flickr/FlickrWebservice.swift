//
//  FlickrWebservice.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import Reachability

typealias HttpDataResult = Swift.Result<Data, DataStoreError>

public class FlickrWebservice: DataStore {
    
    private let reachability = Reachability()
    private let sessionManager: SessionManager
    
    var apiKey: String {
        let infoDictionary = Bundle(for: type(of: self)).infoDictionary
        return infoDictionary?["FLICKR_API_KEY"] as? String ?? ""
    }
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        sessionManager = SessionManager(configuration: configuration)
    }
    
    public func searchGallery(by tag: String, page: UInt, completion: @escaping (GalleryPageResponse) -> Void) {
        
        let endpoint: FlickrEndpoint = .searchTag(tag: tag, page: page, apiKey: apiKey)
        get(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let data):
                let photosWrapper = try! JSONDecoder().decode(PhotosWrapper.self, from: data)
                return self.searchImageDetails(photos: photosWrapper, completion: completion)
            }
        }
    }
    
    private func searchImageDetails(photos: PhotosWrapper, completion: @escaping (GalleryPageResponse) -> Void) {
        
        let group = DispatchGroup()
        var images = [Image]()
        
        let queue = DispatchQueue(label: "image fetcher", qos: .userInitiated)
        
        for id in photos.imageIds {
            group.enter()
            searchImageDetail(id: id) { (response) in
                guard let image = try? response.get() else { return }
                queue.sync {
                    images.append(image)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(.success((Gallery(images: images), photos.pages)))
        }
        
    }
    
    public func searchImageDetail(id: ImageId, completion: @escaping (ImageDetailResponse) -> Void) {
        let endpoint: FlickrEndpoint = .imageDetail(id: id, apiKey: apiKey)
        get(from: endpoint) { (result) in
            let newResult: ImageDetailResponse = result.map { data in
                let sizesWrapper = try! JSONDecoder().decode(SizesWrapper.self, from: data)
                return Image(id: id, urls: sizesWrapper.imageCollection)
            }
            completion(newResult)
        }
    }
    
    private func get(from endpoint: FlickrEndpoint, completion: @escaping (HttpDataResult) -> Void) {
        guard reachability?.connection != .none else {
            return completion(.failure(.noInternetConnection))
        }
        
        sessionManager.request(endpoint.url)
            .responseJSON { [weak self] (dataResponse) in
                guard let self = self else { return }
                let result = self.processHttpResponse(dataResponse)
                completion(result)
        }
    }
    
    private func processHttpResponse<T>(_ dataResponse: DataResponse<T>) -> HttpDataResult {
        let error = self.findErrors(in: dataResponse)
        guard error == nil else {
            return .failure(error!)
        }
        guard let data = dataResponse.data else {
            return .failure(.unknown("Empty response"))
        }
        
        return .success(data)
    }
    
    private func findErrors<T>(in dataResponse: DataResponse<T>) -> DataStoreError? {
        guard let error = dataResponse.error else { return nil }
        
        if let httpCode = dataResponse.response?.statusCode {
            return processHttpErrorResponse(with: httpCode)
        } else {
            return .unknown(error.localizedDescription)
        }
        
    }
    
    private func processHttpErrorResponse(with code: Int) -> DataStoreError {
        let error: DataStoreError
        switch code {
        case 400:
            error = .badRequest
        case 401:
            error = .unauthorized
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 500:
            error = .internalServerError
        case 502:
            error = .badGateway
        case 503:
            error = .unavailable
        default:
            error = .unknown("HTTP code \(code)")
        }
        return error
    }

}
