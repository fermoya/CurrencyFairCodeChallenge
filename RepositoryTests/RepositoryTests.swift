//
//  RepositoryTests.swift
//  RepositoryTests
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import XCTest
import Mockingjay
@testable import Repository

class RepositoryTests: XCTestCase {

    private var dataStore = FlickrWebservice()
    
    private var searchGalleryResponse: [String: Any] = [
        "photos": [
            "page": 1,
            "pages": 4330,
            "perpage": 100,
            "total": "432944",
            "photo": [
                [
                    "id": "48687202342"
                ]
            ]
        ]
    ]
    
    private var imageDetailResponse: [String: Any] = [
        "sizes": [
            "size": [
                [
                    "label": "Square",
                    "source": "https://live.staticflickr.com/65535/48684267196_de736c604b_s.jpg"
                ]
            ]
        ]
    ]
    
    func testSearchTagRequest() {
        let tag = "kitties"
        let page: UInt = 1
        let imageId: UInt = 48687202342
        let apiKey = dataStore.apiKey
        
        stub(uri(FlickrEndpoint.searchTag(tag: tag, page: page, apiKey: apiKey).url),
             json(searchGalleryResponse))
        stub(uri(FlickrEndpoint.imageDetail(id: imageId, apiKey: apiKey).url),
             json(imageDetailResponse))
        
        let expectation = XCTestExpectation(description: "Fetching tag images")
        
        dataStore.searchGallery(by: tag, page: page) { (response) in
            guard let newPage = try? response.get() else {
                return XCTFail()
            }
            
            let gallery = newPage.gallery
            XCTAssertFalse(gallery.images.isEmpty)
            XCTAssertFalse(gallery.images.first!.urls.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testImageDetailRequest() {
        let imageId: UInt = 48687202342
        let apiKey = dataStore.apiKey
        
        stub(uri(FlickrEndpoint.imageDetail(id: imageId, apiKey: apiKey).url),
             json(imageDetailResponse))
        
        let expectation = XCTestExpectation(description: "Fetching image detail")
        
        dataStore.searchImageDetail(id: imageId) { (response) in
            guard let sizes = try? response.get() else {
                return XCTFail()
            }
            
            XCTAssertFalse(sizes.urls.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testResponseForbidden() {
        let imageId: UInt = 48687202342
        let apiKey = dataStore.apiKey
        
        stub(uri(FlickrEndpoint.imageDetail(id: imageId, apiKey: apiKey).url),
             http(403))
        
        let expectation = XCTestExpectation(description: "Mocking forbidden response")
        
        dataStore.searchImageDetail(id: imageId) { (response) in
            switch response {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .forbidden)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
