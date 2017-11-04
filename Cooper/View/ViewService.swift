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
    let deleteFlag = Expression<Int>("delete_flag")
    let id = Expression<Int>("id")
    let createTime = Expression<String>("create_time")
    
    var selectedDatas :AnySequence<Row>!
    
    func selectTableData(searchDate :String) -> [InputDetail] {
        self.database = DatabaseHelper.postRequest()
        
        var inputDetailModel = [InputDetail]()
        
        do{
            let selectedData = self.inputDetailTable.filter(self.deleteFlag == 0 && self.createTime.like("\(searchDate)%"))
            let selectedDatasb = try self.database.prepare(selectedData)
            for data in selectedDatasb {
                let temp = InputDetail.init(
                    id: String(data[Expression<Int>("id")]),
                    amount: String(data[Expression<Int>("amount")]),
                    categoryId: String(data[Expression<Int>("category_id")]),
                    typeFlag: String(data[Expression<Int>("type_flag")]),
                    createTime: data[Expression<Date>("create_time")],
                    updateTime: data[Expression<Date>("update_time")],
                    currencyId: String(data[Expression<Int>("currency_id")]),
                    deleteFlag: String(data[Expression<Int>("delete_flag")]),
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
    
    func selectTableDetailData(segueData :String) -> AnySequence<Row> {
        self.database = DatabaseHelper.postRequest()
        
        do{
            let selectedData = self.inputDetailTable.filter(self.deleteFlag == 0 && self.id == Int(segueData)!)
            let selectedDatas = try self.database.prepare(selectedData)
            self.selectedDatas = selectedDatas
        }catch{
            print(error)
        }
        return self.selectedDatas
    }
    
}
