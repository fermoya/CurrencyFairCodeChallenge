//
//  ImageGalleryContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import BusinessUseCases

final class ImageGalleryContainer {
    
    private let businessContainer: BusinessUseCasesContainer
    private let imageDetailContainer: ImageDetailContainer
    
    init(businessContainer: BusinessUseCasesContainer, imageDetailContainer: ImageDetailContainer) {
        self.businessContainer = businessContainer
        self.imageDetailContainer = imageDetailContainer
    }
    
    var viewModel: ImageGalleryViewModel {
        return ImageGalleryViewModel(dataStorePager: businessContainer.dataStorePager, detailNavigator: imageDetailContainer.navigator)
    }
    
    var viewController: UIViewController {
        return ImageGalleryViewController(viewModel: viewModel)
    }
    
}
