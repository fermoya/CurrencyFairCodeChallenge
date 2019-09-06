//
//  UserInterfaceContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import BusinessUseCases

public final class UserInterfaceContainer {
    
    private let businessContainer: BusinessUseCasesContainer
    private lazy var imageDetailContainer = ImageDetailContainer()
    private lazy var imageGalleryContainer = ImageGalleryContainer(businessContainer: businessContainer, imageDetailContainer: imageDetailContainer)
    
    public init(businessContainer: BusinessUseCasesContainer) {
        self.businessContainer = businessContainer
    }
    
    public var initialViewController: UIViewController {
        return imageGalleryContainer.viewController
    }
    
}
