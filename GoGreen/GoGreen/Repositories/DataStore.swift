//
//  DataStore.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import Foundation
import SQLite

final class DataStore {
    
    static let instance = DataStore()
    public let db: Connection!
    
    private init(){
        let fileName = "TinyNoteGoGreen.sqlite"
        
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString]
        
        let path = dirs[0].appendingPathComponent(fileName)
        print(path)
        
        db = try! Connection(path)
        
    }
    
    public func create() throws {
        try CaseRepository.instance.createTable()
    }
}
