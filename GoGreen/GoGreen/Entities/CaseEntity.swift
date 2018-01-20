//
//  CaseEntity.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import Foundation

final class CaseEntity: Entity {
    var id: Int64
    var value: String
    var status = ""
    var updateTime: Date? = nil
    
    init(id: Int64 = 0, value: String) {
        self.id = id
        self.value = value
    }
}
