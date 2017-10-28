//
//  DatabaseHelper.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/20.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite

class DatabaseHelper{
    
    static func postRequest() -> Connection {
        var database : Connection!
        
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            //common_currency is the name of database
            let fileUrl = documentDirectory.appendingPathComponent("common_currency").appendingPathExtension("sqlite3")
             database = try Connection(fileUrl.path)
        }catch{
            print(error)
        }
        
        return database
    }
}
