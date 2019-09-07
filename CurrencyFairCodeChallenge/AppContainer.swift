//
//  AppContainer.swift
//  CurrencyFairCodeChallenge
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import UserInterface
import Repository
import BusinessUseCases

final class AppContainer {
    
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    private lazy var userInterfaceContainer = UserInterfaceContainer(businessContainer: businessContainer)
    private let repositoryContainer = RepositoryContainer()
    private lazy var businessContainer = BusinessUseCasesContainer(repositoryContainer: repositoryContainer)
    
    init() { }
    
    var rootViewController: UIViewController {
        return userInterfaceContainer.initialViewController
    }
    
}
