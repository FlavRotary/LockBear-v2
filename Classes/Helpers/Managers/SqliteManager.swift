//
//  SqliteManager.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import SQLite

class SQLManager {
    
    var dbPath : String {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        let dbPath = "\(path)/db.sqlite3"
        return dbPath
    }
    var database: Connection?
    let sitesTable = SitesTable()
    let categoriesTable = CategoriesTable()
    
    init(){
        initDB()
    }
    
    func initDB() {
        if !FileManager.default.fileExists(atPath: dbPath) {
            self.createDB()
        } else {
            print("AlreadyCreated")
        }
    }
    
    func getDb() -> Connection {
        if self.database == nil  {
            self.database = try! Connection(dbPath)
        }
        
        return self.database!
    }
    
    func createDB() {
        
        FileManager.default.createFile(atPath: dbPath, contents: nil, attributes: nil)
        
        self.database = try! Connection(dbPath)
        
        do{
            KeychainAndEncryption.createAndStore ()
            try getDb().execute("PRAGMA foreign_keys = ON;")
            try getDb().run(sitesTable.createTable())
            try getDb().run(categoriesTable.createTable())
            let _ = self.createBasicCategories()
            
        } catch {
            print("Tables creation failed: \(error)")
        }
    }
    
    func insertIn <T: SQLTable> (_ table: T,_ item: Any) -> Bool{
        let pair = (table, item)
        do{
            switch pair {
            case let (siteTable,site) as (SitesTable,Site):
                try self.getDb().run(siteTable.insert(site))
            case let (categoriesTable,category) as (CategoriesTable, SiteCategory):
                _ = try self.getDb().run(categoriesTable.insert(category))
            default:
                print("Pair of parameters do not match!")
            }
            return true
        } catch {
            print("Insert into table failed: \(error)")
            return false
        }
    }
    
    func updateIn <T: SQLTable> (_ table: T ,_ item : Any) -> Bool{
        let pair = (table, item)
        do {
            switch pair {
            case let (_,site) as (SitesTable,Site):
                try self.getDb().run(self.sitesTable.update(for: site))
            case let (_,category) as (CategoriesTable, SiteCategory):
                try self.getDb().run(self.categoriesTable.update(for: category))
            default:
                print("Pair of parameters do not match!")
            }
            return true
        } catch {
            print("Update failed: \(error)")
            return false
        }
    }
    
    func deleteIn <T: SQLTable> (_ table: T, _ item: Any) -> Bool{
        let pair = (table,item)
        do {
            switch pair {
            case let (_ ,site) as (SitesTable,Site):
                try self.getDb().run(self.sitesTable.delete(for: site))
            case let (_,section) as (CategoriesTable, SiteCategory):
                try self.getDb().run(self.categoriesTable.delete(for: section))
            default:
                print("Pair of parameters do not match!")
            }
            return true
        } catch {
            print("Delete failed: \(error)")
            return false
        }
    }
    
    func fetchData() -> [SiteCategory] {
        var gotCategories : Array <SiteCategory> = []
//        let categoryid  = Expression<Int64>("categoryid")
//        let sitecategoryid  = Expression<Int64>("sitecategoryid")
//        let t1 = self.sitesTable.table
//        let t2 = self.categoriesTable.table
        do{
            for category in try self.getDb().prepare(self.categoriesTable.table){
                let newCategory = SiteCategory(Int(category[self.categoriesTable.sitecategoryid]), category[self.categoriesTable.name], UIImage(data: Data.fromDatatypeValue(category[self.categoriesTable.icon]))! ,[])
//                let gotSites = t1.join(t2, on: t1[categoryid] == t2[sitecategoryid])
//                for row in try self.getDb().prepare(gotSites) {
//                    let site = Site(Int(row[self.sitesTable.siteid]), Int(row[self.sitesTable.categoryid]), row[self.sitesTable.url], row[self.sitesTable.name], row[self.sitesTable.username])
//                    newCategory.sites.append(site)
//                }
                gotCategories.append(newCategory)
            }
        } catch {
            print("Select from Categories failed: \(error)")
        }
        
        do {
            for site in try self.getDb().prepare(self.sitesTable.table) {
                let newSite = Site()
                newSite.id = Int(site[self.sitesTable.siteid])
                newSite.name = site[self.sitesTable.name]
                newSite.url = site[self.sitesTable.url]
                newSite.username = site[self.sitesTable.username]
                newSite.categoryid = Int(site[self.sitesTable.categoryid])
                
                let gotPass = Data.fromDatatypeValue(site[self.sitesTable.password])
                let gotIv = Data.fromDatatypeValue(site[self.sitesTable.iv])
                
                newSite.password = KeychainAndEncryption.decryptforAES(gotPass, gotIv) ?? ""
                
                let filter = gotCategories.filter { $0.id == newSite.categoryid }
                if filter.count > 0 {
                    newSite.siteCategory = filter.first
                }
                
                newSite.siteCategory?.sites.append(newSite)
            }
        } catch {
            print("Select from Sites failed: \(error)")
        }
        
        return gotCategories
    }
    
    func createBasicCategories() -> Bool {
        var isDone = false
        let basicCategories = ["Social", "Entertainment", "Other"]
        for (index, categoryName) in basicCategories.enumerated(){
            
            let iconName = categoryName.lowercased() + "_icon"
            let newCategory = SiteCategory(index+1, categoryName, UIImage(named: iconName)! ,[])
            isDone = insertIn(self.categoriesTable, newCategory)
            if isDone != true {
                print("Failed to add basic categories! ")
                break
            }
        }
        print("Added Basic Categories!")
        return isDone
    }
    
    func getPass(for site: Site) -> String {
        let siteid = Expression<Int64>("siteid")
        let password = Expression<Blob>("password")
        let iv = Expression<Blob>("iv")
        
        var gotPass: Data!
        var gotIv: Data!
        let query = self.sitesTable.table.select(password,iv)
                                         .filter(siteid == Int64(site.id!))
        for row in try! self.getDb().prepare(query){
            gotPass = Data.fromDatatypeValue(row[self.sitesTable.password])
            gotIv = Data.fromDatatypeValue(row[self.sitesTable.iv])
        }
        if gotPass != nil && gotIv != nil {
            return KeychainAndEncryption.decryptforAES(gotPass, gotIv) ?? "Error with decoding"
        } else {
            return "Error with decoding"
        }
    }
}
