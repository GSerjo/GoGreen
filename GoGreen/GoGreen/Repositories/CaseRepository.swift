//
//  CaseRepository.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import Foundation
import SQLite

final class CaseRepository {
    private let _table = Table("Case")
    static let instance = CaseRepository()
    
    private init(){
    }
    
    func createTable() throws {
        
        let tableQuery = _table.create(ifNotExists: true){ t in
            t.column(Columns.id, primaryKey: true)
            t.column(Columns.value)
            t.column(Columns.status)
            t.column(Columns.updateTime)
        }
        try DataStore.instance.db.run(tableQuery)
    }
    
    public func save(entity: CaseEntity) -> Void {
        let query = self._table.insert(or: .ignore, Columns.value <- entity.value, Columns.status <- entity.status, Columns.updateTime <- entity.updateTime)
        if let id  = try? DataStore.instance.db.run(query) {
            entity.id = id
        }
    }
    
    public func remove(id: Int64) -> Void {
        let query = _table.filter(Columns.id == id).delete()
        _ = try? DataStore.instance.db.run(query)
    }

    public func getAll() -> [CaseEntity] {
        var result = [CaseEntity]()
        
        if let rows = try? DataStore.instance.db.prepare(_table){
            rows.forEach{ row in
                let item = CaseEntity(id: row[Columns.id], value: row[Columns.value])
                result.append(item)
            }
        }
        return result
    }
    
    private struct Columns {
        static let id = Expression<Int64>("id")
        static let value = Expression<String>("value")
        static let status = Expression<String>("status")
        static let updateTime = Expression<Date?>("updateTime")
    }
}

