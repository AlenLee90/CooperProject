//
//  LoginService.swift
//  Cooper
//
//  Created by 李亚男 on 2017/12/24.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import SQLite
import UIKit

class LoginService {
    
    var database : Connection!
    
    let tokenTable = Table("access_token")
    
    func logout(){
        self.database = DatabaseHelper.postRequest()
        do{
            try self.database.run(self.tokenTable.delete())
        } catch {
            print(error)
        }
    }
    
}
