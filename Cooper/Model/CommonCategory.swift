//
//  CommonCategory.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation

class CommonCategory {
    var categoryId: String?
    var categoryName: String?
    var deleteFlag: String?
    
    init(categoryId: String, categoryName: String, deleteFlag: String) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.deleteFlag = deleteFlag
    }
}
