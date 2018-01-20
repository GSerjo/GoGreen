//
//  Entity.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import Foundation

protocol Entity {
    var id: Int64 { get }
}

extension Entity {
    
    var isNew: Bool {
        return id == 0
    }
}

