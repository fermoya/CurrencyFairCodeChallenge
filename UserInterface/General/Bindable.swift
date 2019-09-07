//
//  Bindable.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

protocol ViewModel: class { }

protocol Bindable: class {
    
    associatedtype V where V: ViewModel
    var viewModel: V { get }
    
    func bindViewModel()
}
