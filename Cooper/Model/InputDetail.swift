//
//  InputDetail.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation

class InputDetail {
    var id: String
    var amount: String
    var categoryId: String
    var typeFlag: String
    var createTime: Date
    var updateTime: Date
    var currencyId: String
    var deleteFlag: String
    var comment: String
    var imageAddress: String
    var location: String
    
    init(id: String, amount: String, categoryId: String, typeFlag: String, createTime: Date, updateTime: Date, currencyId: String, deleteFlag: String, comment: String, imageAddress: String, location: String) {
        self.id = id
        self.amount = amount
        self.categoryId = categoryId
        self.typeFlag = typeFlag
        self.createTime = createTime
        self.updateTime = updateTime
        self.currencyId = currencyId
        self.deleteFlag = deleteFlag
        self.comment = comment
        self.imageAddress = imageAddress
        self.location = location
    }
}
