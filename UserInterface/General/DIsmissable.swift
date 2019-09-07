//
//  DIsmissable.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 07/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

typealias DismissableViewController = UIViewController & Dismissable

protocol Dismissable {
    var didFinish: (() -> Void)? { get set }
}
