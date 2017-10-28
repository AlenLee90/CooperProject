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
    
    var selectedDatas :AnySequence<Row>!
    
    func selectTableData() -> AnySequence<Row> {
        self.database = DatabaseHelper.postRequest()
        
        do{
            let selectedData = self.inputDetailTable.filter(self.deleteFlag == 0)
            let selectedDatas = try self.database.prepare(selectedData)
            self.selectedDatas = selectedDatas
        }catch{
            print(error)
        }
        
        return self.selectedDatas
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
