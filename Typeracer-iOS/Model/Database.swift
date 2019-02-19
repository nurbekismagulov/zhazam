//
//  Database.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import RealmSwift

class Database {
    
    static let database = Database()
    
    func copyDatabase(completionHandler: @escaping(Realm.Configuration) -> ()) {
        
        let docsurl = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let url = docsurl.appendingPathComponent("db.realm")
        var config = Realm.Configuration(fileURL: url, readOnly: false)
        config.schemaVersion = 15
        
        let fileExists = (try? url.checkResourceIsReachable()) ?? false
        
        if fileExists {
            print("database exists")
            completionHandler(config)
        } else {
            print("database doesn't exist")
            do {
                try FileManager.default.copyItem(at: Bundle.main.url(forResource: "db", withExtension: "realm")!, to: url)
                print("database copied")
                completionHandler(config)
            } catch {
                print("error")
            }
        }
    }
    
    func fetchRealmData() -> Text {
        var texts: Text = Text()
        if let object = realm?.objects(Text.self){
            let random = Int(arc4random_uniform(UInt32(object.count)))
            texts = (realm?.objects(Text.self)[random])!
        }
        return texts
    }
    
}
