//
//  SecondViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/15.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite

class SecondViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet var tableView: UIView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    var viewData:String!
    
    var segueData :String?
    
    let viewService = ViewService()
    
    var inputDetailModel :InputDetail?
    
    var database: Connection!
    let commonCurrencyTable = Table("common_currency")
    let currencyId = Expression<Int>("currency_id")
    let currencyCode = Expression<String>("currency_code")
    let deleteFlag = Expression<Int>("delete_flag")
    let commonPeriodTable = Table("common_period")
    let periodId = Expression<Int>("period_id")
    let periodLength = Expression<Int>("period_length")
    let id = Expression<Int>("id")
    let amount = Expression<Int>("amount")
    let categoryId = Expression<Int>("category_id")
    let typeFlag = Expression<Int>("type_flag")
    let createTime = Expression<Date>("create_time")
    let updateTime = Expression<Date>("update_time")
    let comment = Expression<String>("comment")
    let imageAddress = Expression<String>("image_address")
    let location = Expression<String>("location")
    let commonCategoryTable = Table("common_category")
    let inputDetailTable = Table("input_detail")
    let categoryName = Expression<String>("category_name")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database = DatabaseHelper.postRequest()
        
        for detailList in viewService.selectTableDetailData(segueData: segueData!) {
            inputDetailModel = InputDetail(
                id: String(detailList[Expression<Int>("id")]),
                amount: String(detailList[Expression<Int>("amount")]),
                categoryId: String(detailList[Expression<Int>("category_id")]),
                typeFlag: String(detailList[Expression<Int>("type_flag")]),
                createTime: detailList[Expression<Date>("create_time")],
                updateTime: detailList[Expression<Date>("update_time")],
                currencyId: String(detailList[Expression<Int>("currency_id")]),
                deleteFlag: String(detailList[Expression<Int>("delete_flag")]),
                comment: detailList[Expression<String>("comment")],
                imageAddress: detailList[Expression<String>("image_address")],
                location: detailList[Expression<String>("location")])
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        locationLabel.text = "Location: "+(inputDetailModel?.location)!
        currencyLabel.text = "Currency: "+(inputDetailModel?.currencyId)!
        timeLabel.text = "Time: "+formatter.string(from: (inputDetailModel?.createTime)!)
        typeLabel.text = "Category: "+(inputDetailModel?.categoryId)!
        amountLabel.text = "Amount: "+(inputDetailModel?.amount)!
    }
    
    @IBAction func createTable(_ sender: UIButton) {
        print("CREATE TABLE")
        
        let createCurrencyTable = self.commonCurrencyTable.create{(table) in
            table.column(self.currencyId,primaryKey:true)
            table.column(self.currencyCode)
            table.column(self.deleteFlag)
        }
        
        let createPeriodTale = self.commonPeriodTable.create{(table) in
            table.column(self.periodId,primaryKey:true)
            table.column(self.periodLength)
            table.column(self.deleteFlag)
        }
        
        let createCategoryTable = self.commonCategoryTable.create{(table) in
            table.column(self.categoryId,primaryKey:true)
            table.column(self.categoryName)
            table.column(self.deleteFlag)
        }
        
        let createInputDetailTable = self.inputDetailTable.create{(table) in
            table.column(self.id,primaryKey:true)
            table.column(self.amount)
            table.column(self.categoryId)
            table.column(self.typeFlag)
            table.column(self.currencyId)
            table.column(self.comment)
            table.column(self.imageAddress)
            table.column(self.location)
            table.column(self.createTime)
            table.column(self.updateTime)
            table.column(self.deleteFlag)
        }
        
        do{
            try self.database.run(createCurrencyTable)
            print("Created Currency Table")
        }catch{
            print(error)
        }
        
        do{
            try self.database.run(createPeriodTale)
            print("Created Period Table")
        }catch{
            print(error)
        }
        
        do{
            try self.database.run(createCategoryTable)
            print("Created Category Table")
        }catch{
            print(error)
        }
        
        do{
            try self.database.run(createInputDetailTable)
            print("Created InputData Table")
        }catch{
            print(error)
        }
        
        do{
        try self.database.run(commonCurrencyTable.addColumn(Expression<Int?>("status")))
        }catch{
            print(error)
        }
    }
    
    @IBAction func InsertData(_ sender: UIButton) {
        print("Inserting Data")
       
        let temp = ["USD","JPY","CNY","EUR","GBP"]
        
        for data in temp{
        
        let insertData = self.commonCurrencyTable.insert(self.currencyCode <- data,self.deleteFlag <- 0)
        
        do{
            try self.database.run(insertData)
            print("Inserted Data")
        }catch{
            print(error)
        }
        
        }
    }
    
    @IBAction func selectData(_ sender: UIButton) {
        do{
//            let updateData = self.commonCurrencyTable.filter(self.deleteFlag == 0 && self.currencyCode == "USD")
//            let updateQuery = updateData.update( Expression<Int>("status") <- 1)
//            try self.database.run(updateQuery)
        let selectedDatas = try self.database.prepare(self.commonCurrencyTable)
            for selectedData in selectedDatas{
//                print("id: \(selectedData[self.id]) ,code: \(selectedData[self.categoryId]),typeFlag: \(selectedData[self.typeFlag]),createTime: \(selectedData[self.createTime]),amount: \(selectedData[self.amount]),location: \(selectedData[self.location])")
                print(selectedData[Expression<Int>("status")])
            }
        }catch{
            print(error)
        }
    }
    
    

}
