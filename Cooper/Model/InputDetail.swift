//
//  InputDetail.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
//import SQLite
//import UIKit

class InputDetail {
//    var id: String = ""
//    var amount: String = ""
//    var categoryId: String = ""
//    var typeFlag: String = ""
//    var createTime: String = ""
//    var updateTime: String = ""
//    var currencyId: String = ""
//    var deleteFlag: String = ""
//    var comment: String = ""
//    var imageUrl: String = ""
//    var location: String = ""
//
//    var database : Connection!
//    let inputTable = Table("input_cache")
//    let currencyTable = Table("currencies")
//    let inputDataService = InputDataService()
//
//    func saveData(inputDetailModel : [InputDetail]) {
//        self.database = DatabaseHelper.postRequest()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let user_id = inputDataService.getUserId()
//        for index in 1...inputDetailModel.count{
//            do{
//            try self.database.run(self.inputTable.insert(
//                Expression<Int?>("amount") <- Int(inputDetailModel[index-1].amount),
//                Expression<Int?>("user_id") <- Int(user_id),
//                Expression<Int?>("category_id") <- Int(inputDetailModel[index-1].categoryId),
//                Expression<Int?>("consumption_flag") <- Int(inputDetailModel[index-1].typeFlag),
//                Expression<Date?>("created_at") <- dateFormatter.date(from: inputDetailModel[index-1].createTime),
//                Expression<Date?>("updated_at") <- dateFormatter.date(from: inputDetailModel[index-1].updateTime),
//                Expression<Int?>("currency_id") <- Int(inputDetailModel[index-1].currencyId),
//                Expression<String?>("comment") <- inputDetailModel[index-1].comment,
//                Expression<String?>("image_url") <- inputDetailModel[index-1].imageUrl,
//                Expression<String?>("location") <- inputDetailModel[index-1].location
//            ))
//            } catch {
//                print(error)
//            }
//        }
//    }
//
//    func checkDataExist() -> Int {
//        self.database = DatabaseHelper.postRequest()
//        var result:Int?
//        do {
//            try result = self.database.scalar(inputTable.count)
//        } catch {
//            print(error)
//        }
//        return result!
//    }
//
//    func getTableData(searchDate :String) -> [InputDetail] {
//        self.database = DatabaseHelper.postRequest()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        var inputDetailModel = [InputDetail]()
//        var dic :InputDetail?
//        do{
////            let selectedData = self.inputTable.filter(inputTable[Expression<Int>("delete_flag")] == 0 && Expression<String>("created_at").like("\(searchDate)%")).join(currencyTable, on: inputTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")])
//            let selectedData = self.inputTable.filter(inputTable[Expression<Int>("delete_flag")] == 0).join(currencyTable, on: inputTable[Expression<Int>("currency_id")] == currencyTable[Expression<Int>("currency_id")])
//            let selectedDatasb = try self.database.prepare(selectedData)
//            for data in selectedDatasb {
//                print("fourth")
//                print(String(data[Expression<Int>("id")]))
////                dic.id = String(data[Expression<Int>("id")])
//                dic?.amount = String(data[Expression<Int>("amount")])
////                dic.categoryId = String(data[Expression<Int>("category_id")])
////                dic.typeFlag = String(data[Expression<Int>("type_flag")])
////                dic.createTime = String(describing: data[Expression<Date>("create_time")])
////                dic.updateTime = String(describing: data[Expression<Date>("update_time")])
////                dic.currencyId = String(data[Expression<Int>("currency_id")])
////                dic.deleteFlag = String(data[Expression<Int>("delete_flag")])
////                dic.imageUrl = String(data[Expression<String>("image_url")])
////                dic.location = String(data[Expression<String>("location")])
//                print(dic!)
//                print(String(data[Expression<String>("location")]))
//                inputDetailModel.append(dic!)
//            }
//
//        }catch{
//            print(error)
//        }
//        return inputDetailModel
//    }
    var id: String
    var amount: String
    var categoryId: String
    var typeFlag: String
    var createdAt: String
    var updatedAt: String
    var currencyId: String
    var deleteFlag: String
    var comment: String
    var imageUrl: String
    var location: String
    
    init(id: String, amount: String, categoryId: String, typeFlag: String, createdAt: String, updatedAt: String, currencyId: String, deleteFlag: String, comment: String, imageUrl: String, location: String) {
        self.id = id
        self.amount = amount
        self.categoryId = categoryId
        self.typeFlag = typeFlag
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.currencyId = currencyId
        self.deleteFlag = deleteFlag
        self.comment = comment
        self.imageUrl = imageUrl
        self.location = location
    }
    
}
