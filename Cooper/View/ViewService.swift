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
    
    let inputDetailTable = Table("input_cache")
    let categoryTable = Table("categories")
    let currencyTable = Table("currencies")
    let deleteFlag = Expression<Int>("delete_flag")
    let id = Expression<Int>("id")
    let createTime = Expression<String>("create_time")
    let inputDataService = InputDataService()
    
    var selectedDatas :AnySequence<Row>!
    
    func selectTableData(searchDate :String) -> [InputDetail] {
        self.database = DatabaseHelper.postRequest()
        
        var inputDetailModel = [InputDetail]()
        
        do{
            let selectedData = self.inputDetailTable.filter(inputDetailTable[self.deleteFlag] == 0).join(currencyTable, on: inputDetailTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")])
            let selectedDatasb = try self.database.prepare(selectedData)
            for data in selectedDatasb {
                let temp = InputDetail.init(
                    id: String(data[Expression<Int>("id")]),
                    amount: String(data[Expression<Int>("amount")]),
                    categoryId: String(data[Expression<Int>("category_id")]),
                    typeFlag: String(data[Expression<Int>("consumption_flag")]),
                    createdAt: data[Expression<String>("created_at")],
                    updatedAt: data[Expression<String>("updated_at")],
                    currencyId: String(data[inputDetailTable[Expression<Int>("currency_id")]]),
                    deleteFlag: String(data[inputDetailTable[Expression<Int>("delete_flag")]]),
                    comment: data[Expression<String>("comment")],
                    imageUrl: data[Expression<String>("image_url")],
                    location: data[Expression<String>("location")])
                inputDetailModel.append(temp)
            }
            
        }catch{
            print(error)
        }
        
        return inputDetailModel
    }
    
    func deleteTableData(id :String) -> Bool {
        self.database = DatabaseHelper.postRequest()
        print(id)
        let updateData = self.inputDetailTable.filter(self.id == Int(id)!)
        let updateQuery = updateData.update(self.deleteFlag <- 1)
        var status = false
        do {
            try self.database.run(updateQuery)
            status = true
        } catch {
            print(error)
        }
        return status
    }
    
//    func selectTableDetailData(segueData :String) -> [InputDetail] {
//        self.database = DatabaseHelper.postRequest()
//
//        var inputDetailModel = [InputDetail]()
//
//        do{
//            let selectedData = self.inputDetailTable.filter(inputDetailTable[self.deleteFlag] == 0 && self.id == Int(segueData)!).join(currencyTable, on: inputDetailTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")]).join(self.categoryTable, on: inputDetailTable[Expression<Int>("category_id")] == categoryTable[Expression<Int>("category_id")])
//            let selectedDatasb = try self.database.prepare(selectedData)
//            for data in selectedDatasb {
//                let temp = InputDetail.init(
//                    id: String(data[Expression<Int>("id")]),
//                    amount: String(data[Expression<Int>("amount")]),
//                    categoryId: String(data[inputDetailTable[Expression<Int>("category_id")]]),
//                    categoryName: data[Expression<String>("category_name")],
//                    typeFlag: String(data[Expression<Int>("type_flag")]),
//                    createTime: data[Expression<Date>("create_time")],
//                    updateTime: data[Expression<Date>("update_time")],
//                    currencyId: String(data[inputDetailTable[Expression<Int>("currency_id")]]),
//                    currencyCode: data[Expression<String>("currency_code")],
//                    deleteFlag: String(data[inputDetailTable[Expression<Int>("delete_flag")]]),
//                    comment: data[Expression<String>("comment")],
//                    imageAddress: data[Expression<String>("image_address")],
//                    location: data[Expression<String>("location")])
//                inputDetailModel.append(temp)
//            }
//        }catch{
//            print(error)
//        }
//        return inputDetailModel
//    }
    func checkDataExist() -> Int {
        self.database = DatabaseHelper.postRequest()
        var result:Int?
        do {
            try result = self.database.scalar(inputDetailTable.count)
        } catch {
            print(error)
        }
        return result!
    }
    
    func saveData(inputDetailModel : [InputDetail]) {
        self.database = DatabaseHelper.postRequest()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let user_id = inputDataService.getUserId()
        for index in 1...inputDetailModel.count{
            do{
            try self.database.run(self.inputDetailTable.insert(
                Expression<Int?>("id") <- Int(inputDetailModel[index-1].id),
                Expression<Int?>("amount") <- Int(inputDetailModel[index-1].amount),
                Expression<Int?>("user_id") <- Int(user_id),
                Expression<Int?>("category_id") <- Int(inputDetailModel[index-1].categoryId),
                Expression<Int?>("consumption_flag") <- Int(inputDetailModel[index-1].typeFlag),
                Expression<Date?>("created_at") <- dateFormatter.date(from: inputDetailModel[index-1].createdAt),
                Expression<Date?>("updated_at") <- dateFormatter.date(from: inputDetailModel[index-1].updatedAt),
                Expression<Int?>("currency_id") <- Int(inputDetailModel[index-1].currencyId),
                Expression<String?>("comment") <- inputDetailModel[index-1].comment,
                Expression<String?>("image_url") <- inputDetailModel[index-1].imageUrl,
                Expression<String?>("location") <- inputDetailModel[index-1].location
            ))
            } catch {
                print(error)
            }
        }
    }
}
