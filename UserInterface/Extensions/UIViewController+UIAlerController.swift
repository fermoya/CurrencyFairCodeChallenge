//
//  UIViewController+UIAlerController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 07/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func showErrorAlert(message: String) {
        showErrorAlert(message: message, handler: nil)
    }
    
    func showErrorAlert(message: String, handler: (() -> Void)?) {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
