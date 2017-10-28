//
//  InputDataService.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import SQLite
import UIKit

class InputDataService {
    
    
    var database : Connection!
    let categoryTable = Table("common_category")
    
    func selectPickerList() -> AnySequence<Row> {
        self.database = DatabaseHelper.postRequest()
        var pickerLists :AnySequence<Row>?
        do{
            pickerLists = try self.database.prepare(self.categoryTable)
        } catch {
            print(error)
        }
        return pickerLists!
    }
    
    func insertData(inputDetailModal : InputDetail) -> Bool {
        var status = false
        
        do{
            try self.database.run(Table("input_detail").insert(
                Expression<Int?>("amount") <- Int((inputDetailModal.amount)),
                Expression<Int?>("category_id") <- Int((inputDetailModal.categoryId)),
                Expression<Int?>("type_flag") <- Int((inputDetailModal.typeFlag)),
                Expression<Date?>("create_time") <- inputDetailModal.createTime,
                Expression<Date?>("update_time") <- inputDetailModal.updateTime,
                Expression<Int?>("currency_id") <- Int((inputDetailModal.currencyId)),
                Expression<Int?>("delete_flag") <- Int((inputDetailModal.deleteFlag)),
                Expression<String?>("comment") <- inputDetailModal.comment,
                Expression<String?>("image_address") <- inputDetailModal.imageAddress,
                Expression<String?>("location") <- inputDetailModal.location
            ))
            print("Inserted Data")
            status = true
        }catch{
            print(error)
        }
        
        return status
    }
    
}
