//
//  ImageDetailContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

protocol ImageDetailViewControllerProvider {
    func viewController(for imageUrl: String) -> ImageDetailViewController
}

final class ImageDetailContainer {
    
    var navigator: ImageDetailNavigator {
        return ImageDetailNavigator(viewControllerProvider: self)
    }
    
    func viewController(for imageUrl: String) -> ImageDetailViewController {
        return ImageDetailViewController(imageUrl: imageUrl)
    }
    
}

extension ImageDetailContainer: ImageDetailViewControllerProvider { }
