//
//  ViewService.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import SQLite
import UIKit

class ViewService {
    
    var database : Connection!
    
    let inputDetailTable = Table("input_detail")
    let categoryTable = Table("common_category")
    let currencyTable = Table("common_currency")
    let deleteFlag = Expression<Int>("delete_flag")
    let id = Expression<Int>("id")
    let createTime = Expression<String>("create_time")
    
    var selectedDatas :AnySequence<Row>!
    
    func selectTableData(searchDate :String) -> [InputDetail] {
        self.database = DatabaseHelper.postRequest()
        
        var inputDetailModel = [InputDetail]()
        
        do{
            let selectedData = self.inputDetailTable.filter(inputDetailTable[self.deleteFlag] == 0 && self.createTime.like("\(searchDate)%")).join(currencyTable, on: inputDetailTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")])
            let selectedDatasb = try self.database.prepare(selectedData)
            for data in selectedDatasb {
                let temp = InputDetail.init(
                    id: String(data[Expression<Int>("id")]),
                    amount: String(data[Expression<Int>("amount")]),
                    categoryId: String(data[Expression<Int>("category_id")]),
                    categoryName: "",
                    typeFlag: String(data[Expression<Int>("type_flag")]),
                    createTime: data[Expression<Date>("create_time")],
                    updateTime: data[Expression<Date>("update_time")],
                    currencyId: String(data[inputDetailTable[Expression<Int>("currency_id")]]),
                    currencyCode: data[Expression<String>("currency_code")],
                    deleteFlag: String(data[inputDetailTable[Expression<Int>("delete_flag")]]),
                    comment: data[Expression<String>("comment")],
                    imageAddress: data[Expression<String>("image_address")],
                    location: data[Expression<String>("location")])
                inputDetailModel.append(temp)
            }
            
        }catch{
            print(error)
        }
        
        return inputDetailModel
    }
    
    func deleteTableData(updateQuery : Update) -> Bool {
        self.database = DatabaseHelper.postRequest()
        var status = false
        do {
            try self.database.run(updateQuery)
            status = true
        } catch {
            print(error)
        }
        return status
    }
    
    func selectTableDetailData(segueData :String) -> [InputDetail] {
        self.database = DatabaseHelper.postRequest()
        
        var inputDetailModel = [InputDetail]()
        
        do{
            let selectedData = self.inputDetailTable.filter(inputDetailTable[self.deleteFlag] == 0 && self.id == Int(segueData)!).join(currencyTable, on: inputDetailTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")]).join(self.categoryTable, on: inputDetailTable[Expression<Int>("category_id")] == categoryTable[Expression<Int>("category_id")])
            let selectedDatasb = try self.database.prepare(selectedData)
            for data in selectedDatasb {
                let temp = InputDetail.init(
                    id: String(data[Expression<Int>("id")]),
                    amount: String(data[Expression<Int>("amount")]),
                    categoryId: String(data[inputDetailTable[Expression<Int>("category_id")]]),
                    categoryName: data[Expression<String>("category_name")],
                    typeFlag: String(data[Expression<Int>("type_flag")]),
                    createTime: data[Expression<Date>("create_time")],
                    updateTime: data[Expression<Date>("update_time")],
                    currencyId: String(data[inputDetailTable[Expression<Int>("currency_id")]]),
                    currencyCode: data[Expression<String>("currency_code")],
                    deleteFlag: String(data[inputDetailTable[Expression<Int>("delete_flag")]]),
                    comment: data[Expression<String>("comment")],
                    imageAddress: data[Expression<String>("image_address")],
                    location: data[Expression<String>("location")])
                inputDetailModel.append(temp)
            }
        }catch{
            print(error)
        }
        return inputDetailModel
    }
    
}
