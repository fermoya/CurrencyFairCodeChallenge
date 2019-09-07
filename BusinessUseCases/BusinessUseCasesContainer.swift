//
//  BusinessUseCasesContainer.swift
//  BusinessUseCases
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository

public final class BusinessUseCasesContainer {
    
    private let repositoryContainer: RepositoryContainer
    
    public init(repositoryContainer: RepositoryContainer) {
        self.repositoryContainer = repositoryContainer
    }
    
    public var dataStorePager: DataStorePager {
        return DataStorePager(dataStore: repositoryContainer.dataStore)
    }
    
}
