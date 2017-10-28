//
//  CommonCurrency.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation

class CommonCurrency {
    var currencyId: String?
    var currencyCode: String?
    var deleteFlag: String?
    var status: String?
    
    init(currencyId: String, currencyCode: String, deleteFlag: String, status: String) {
        self.currencyId = currencyId
        self.currencyCode = currencyCode
        self.deleteFlag = deleteFlag
        self.status = status
    }
}
