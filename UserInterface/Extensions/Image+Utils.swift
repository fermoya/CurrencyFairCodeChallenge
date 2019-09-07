//
//  Image+Utils.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 06/09/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

extension Image {
    func url(for size: Size) -> String? {
        return urls[size]
    }
}
