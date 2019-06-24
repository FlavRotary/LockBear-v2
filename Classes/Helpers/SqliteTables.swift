//
//  SitesTables.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import SQLite

protocol SQLTable {
    associatedtype tableType
    func createTable() -> String
    func insert(_ item: tableType) -> Insert
    func update(for item: tableType) -> Update
    func delete(for item: tableType) -> Delete
}

struct SitesTable{
    
    typealias tableType =  Site
    let table = Table("sites")
    let siteid  = Expression<Int64>("siteid")
    var categoryid = Expression<Int64>("categoryid")
    var name = Expression<String>("name")
    var url = Expression<String>("url")
    var username = Expression<String>("username")
    var password = Expression<Blob>("password")
    var iv = Expression<Blob>("iv")
    var icon = Expression<Blob>("icon")
}

extension SitesTable: SQLTable{
    
    func createTable() -> String {
        let statement = table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {t in
            t.column(siteid, primaryKey: PrimaryKey.autoincrement)
            t.column(categoryid)
            t.column(name)
            t.column(url)
            t.column(username)
            t.column(password)
            t.column(iv)
            t.column(icon)
        })
        return statement
    }
    
    func insert(_ item: Site) -> Insert {
        let gotSite = item
        gotSite.nilCheck()
        let (resultedPass, resultediv) = KeychainAndEncryption.ecryptWithAES(gotSite.password)
        item.state = .isHidden
        gotSite.state = .isHidden
        let statement = table.insert(or: .replace,
                                     self.categoryid <- Int64(gotSite.categoryid),
                                     self.name <- gotSite.name,
                                     self.url <- gotSite.url,
                                     self.username <- gotSite.username,
                                     self.password <- Blob(bytes: [UInt8](resultedPass!)),
                                     self.iv <- Blob(bytes: [UInt8](resultediv!)),
                                     self.iv <- Blob(bytes: [UInt8](gotSite.icon.pngData()!)))
        return statement
    }
    
    func update(for site: Site) -> Update{
        
        let gotSite = site
        gotSite.nilCheck()
        let (resultedPass, resultediv) = KeychainAndEncryption.ecryptWithAES(gotSite.password)
        gotSite.state = .isHidden
        site.state = .isHidden
        let gotRow = table.filter(siteid == Int64(gotSite.id!))
        
        let statement = gotRow.update(
            [self.categoryid <- Int64(site.categoryid),
             self.name <- site.name,
             self.url <- site.url,
             self.username <- site.username,
             self.password <- Blob(bytes: [UInt8](resultedPass!)),
             self.iv <- Blob(bytes: [UInt8](resultediv!)),
             self.icon <- Blob(bytes: [UInt8](site.icon.pngData()!))])
        return statement
    }
    
    func delete(for site: Site) -> Delete{
        let gotRow = table.filter(self.siteid == Int64(site.id!))
        let statement = gotRow.delete()
        return statement
    }
    
}


struct CategoriesTable{
    
    typealias tableType = SiteCategory
    var table = Table("categories")
    let sitecategoryid = Expression<Int64>("sitecategoryid")
    var name = Expression<String>("name")
    var icon = Expression<Blob>("icon")
}

extension CategoriesTable: SQLTable{
    
    func createTable() -> String {
        let statement = table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {t in
            t.column(sitecategoryid, primaryKey: PrimaryKey.autoincrement)
            t.column(name, unique: true)
            t.column(icon)
        })
        return statement
    }
    
    func insert(_ item: SiteCategory) -> Insert {
        let statement = table.insert(or: .replace, self.name <- item.name!, self.icon <- Blob(bytes: [UInt8](item.icon.pngData()!)))
        return statement
    }
    
    func update(for category: SiteCategory) -> Update{
        let gotRow = table.filter(self.sitecategoryid == Int64(category.id!))
        let statement = gotRow.update([self.name <- category.name!,
                                       self.icon <- Blob(bytes: [UInt8](category.icon.pngData()!))])
        return statement
    }
    
    func delete(for category: SiteCategory) -> Delete{
        let gotRow = table.filter(self.sitecategoryid == Int64(category.id!))
        let statement = gotRow.delete()
        return statement
    }
    
}
