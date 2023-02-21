//
//  DB_Manager.swift
//  SwiftUIWithSqlite
//
//  Created by Abhishek Bagela on 20/02/23.
//

import Foundation
import SQLite


class DB_Manager {
    
    private var db: Connection!
    
    private var record: Table!
    
    private var id: Expression<String>!
    private var name: Expression<String>!
    private var calorie: Expression<String>!
    private var quantity: Expression<String>!
    
    init() {
        do {
            //NOTE: local dir. path
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            //NOTE: make connection to store the data in the file of the location
            db = try Connection("\(path)/record.sqlite3") ///Users/Projects/SwiftUIWithSqlite
            
            //NOTE: give table name
            record = Table("records")
            
            //NOTE: create columns name
            id = Expression<String>("id")
            name = Expression<String>("name")
            calorie = Expression<String>("calorie")
            quantity = Expression<String>("quantity")
            
            //NOTE: check is table created or not if yes then don't create if no then create
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                
                try db.run(record.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(calorie)
                    t.column(quantity)
                })
                //NOTE: set is_db_created = true for not creating a table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        } catch {
            //NOTE: show error if any occure
            print(error.localizedDescription)
        }
    }
    
    public func save(rec: Record) {
        do {
            try db.run(record.insert(id <- rec.id,
                                      name <- rec.name ?? "",
                                      calorie <- rec.calorie ?? "",
                                      quantity <- rec.qty ?? ""))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    public func getAllRecords() -> [Record] {
        
        var records: [Record] = []
        
        record = record.order(id.desc)
        
        do {
            for rec in try db.prepare(record) {
                let record: Record = Record()
                record.id = rec[id]
                record.name = rec[name]
                record.calorie = rec[calorie]
                record.qty = rec[quantity]
                
                records.append(record)
                
            }
        } catch {
            print(error.localizedDescription)
        }

        print("All records")
        dump(records)
        return records
    }
    
    public func edit(rec: Record) {
        do {
            let record: Table = record.filter(id == rec.id)
            
            try db.run(record.update(name     <- rec.name ?? "",
                                     calorie  <- rec.calorie ?? "",
                                     quantity <- rec.qty ?? ""
                                ))
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func delete(recordId: String) {
        do {
            let record: Table = record.filter(id == recordId)
         
            try db.run(record.delete())
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
