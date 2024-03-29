//
//  ImageDetailNavigator.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

class ImageDetailNavigator {
    
    private let viewControllerProvider: ImageDetailViewControllerProvider
    
    init(viewControllerProvider: ImageDetailViewControllerProvider) {
        self.viewControllerProvider = viewControllerProvider
    }
    
    func navigateDetail(of imageUrl: String, from parent: UIViewController) {
        var viewController = viewControllerProvider.viewController(for: imageUrl)
        
        weak var weakViewController = viewController
        viewController.didFinish = {
            weakViewController?.dismiss(animated: true)
        }
        parent.present(viewController, animated: true)
    }
    
}
