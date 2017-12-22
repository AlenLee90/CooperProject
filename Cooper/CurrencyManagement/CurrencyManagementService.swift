//
//  CurrencyManagementService.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/29.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import SQLite

class CurrencyManagementService {
    
    var database : Connection!
    
    var selectedDatas :AnySequence<Row>!
    
    let currencyTable = Table("currencies")
    
    let deleteFlag = Expression<Int>("delete_flag")
    let status = Expression<Int>("status")
    let currencyId = Expression<Int>("currency_id")
    let currencyCode = Expression<String>("currency_code")
    
    func selectCurrencyList() -> AnySequence<Row> {
        self.database = DatabaseHelper.postRequest()
        
        do{
            let selectedData = self.currencyTable.filter(self.deleteFlag == 0)
            let selectedDatas = try self.database.prepare(selectedData)
            self.selectedDatas = selectedDatas
        }catch{
            print(error)
        }
        
        return self.selectedDatas
        
    }
    
    func didSelectUpdate(currencyId :Int){
        self.database = DatabaseHelper.postRequest()
        
        do {
        let updateData = self.currencyTable.filter(self.deleteFlag == 0)
        let updateQuery = updateData.update( Expression<Int>("status") <- 0)
        try self.database.run(updateQuery)
        
        let updateDataTwo = self.currencyTable.filter(self.deleteFlag == 0 && self.currencyId == currencyId)
        let updateQueryTwo = updateDataTwo.update( Expression<Int>("status") <- 1)
        try self.database.run(updateQueryTwo)
        }catch{
            print(error)
        }
        
    }
    
    func selectCurrencyCode() -> String {
        self.database = DatabaseHelper.postRequest()
        var currencyCode :String?
        do{
            let selectedData = self.currencyTable.filter(self.deleteFlag == 0 && self.status == 1)
            let selectedDatas = try self.database.prepare(selectedData)
            for data in selectedDatas {
                currencyCode = data[Expression<String>("currency_code")]
            }
        }catch{
            print(error)
        }
        return currencyCode!
    }
    
    func selectCurrencyId(currencyCode :String) -> String {
        self.database = DatabaseHelper.postRequest()
        var currencyId :String?
        do{
            let selectedData = self.currencyTable.filter(self.deleteFlag == 0 && self.currencyCode == currencyCode)
            let selectedDatas = try self.database.prepare(selectedData)
            for data in selectedDatas {
                currencyId = String(data[Expression<Int>("currency_id")])
            }
        }catch{
            print(error)
        }
        return currencyId!
    }
    
}
