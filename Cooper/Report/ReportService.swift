//
//  ReportService.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/28.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import SQLite
import UIKit
import Charts

class ReportService {
    
    var database : Connection!
    
    func selectResultData() -> NSAttributedString {
        self.database = DatabaseHelper.postRequest()
        
        var paymentAmount :String?
        var incomeAmount :String?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: Date())
        do{
            let stmt = try self.database.prepare("SELECT ifnull(sum(amount),0) as amount FROM input_detail where type_flag='0' and delete_flag='0' and create_time like '\(myString)%'")
            for row in stmt {
                for (index, name) in stmt.columnNames.enumerated() {
                    if name == "amount" {
                        paymentAmount = String(describing: row[index]!)
                    }
                }
            }
            
        }catch{
            print(error)
        }
        do{
            let stmt = try self.database.prepare("SELECT ifnull(sum(amount),0) as amount FROM input_detail where type_flag='1' and delete_flag='0' and create_time like '\(myString)%'")
            for row in stmt {
                for (index, name) in stmt.columnNames.enumerated() {
                    if name == "amount" {
                        incomeAmount = String(describing: row[index]!)
                    }
                }
            }
            
        }catch{
            print(error)
        }
        let text = "You spend  "+String(Double(paymentAmount!)! + (-Double(incomeAmount!)!))+"  today."
        let nsText = text as NSString
        let textRange = NSMakeRange(9, nsText.length - 15)
        let myMutableString = NSMutableAttributedString(
            string: text,
            attributes: [:])
        myMutableString.addAttribute(
            NSAttributedStringKey.foregroundColor,
            value: UIColor.red,
            range: textRange)
        let resultString = myMutableString
        return resultString
    }
    
    func getPaymentData() -> [PieChartDataEntry] {
        self.database = DatabaseHelper.postRequest()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: Date())
        
        var paymentEntryArray = [PieChartDataEntry]()
    
        do{
            let stmt = try self.database.prepare("SELECT ifnull(sum(a.amount),0) as amount,b.category_name FROM input_detail as a left join common_category as b on a.category_id = b.category_id where a.type_flag = '0' and a.delete_flag = 0 and a.create_time like '\(myString)%' group by a.category_id")
            for row in stmt {
                var label :String?
                var amount :String?
    
                for (index, name) in stmt.columnNames.enumerated() {
                    if name == "category_name" {
                        label = row[index]! as? String
                    }
                    if name == "amount" {
                        amount = String(describing: row[index]!)
                    }
                }
                if amount!.isEmpty {
                    //github push
                    amount = "0"
                }
    
                let entry = PieChartDataEntry(value: Double(amount!)!, label: label)
                paymentEntryArray.append(entry)
            }
    
        }catch{
            print(error)
        }
        return paymentEntryArray
    }
    
    func getIncomeData() -> [PieChartDataEntry] {
        self.database = DatabaseHelper.postRequest()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: Date())
        
        var incomeEntryArray = [PieChartDataEntry]()
        
        do{
            let stmt = try self.database.prepare("SELECT ifnull(sum(a.amount),0) as amount,b.category_name FROM input_detail as a left join common_category as b on a.category_id = b.category_id where a.type_flag = '1' and a.delete_flag = 0 and a.create_time like '\(myString)%' group by a.category_id")
            for row in stmt {
                var label :String?
                var amount :String?
                
                for (index, name) in stmt.columnNames.enumerated() {
                    if name == "category_name" {
                        label = row[index]! as? String
                    }
                    if name == "amount" {
                        amount = String(describing: row[index]!)
                    }
                }
                if amount!.isEmpty {
                    //github push
                    amount = "0"
                }
                
                let entry = PieChartDataEntry(value: Double(amount!)!, label: label)
                incomeEntryArray.append(entry)
            }
            
        }catch{
            print(error)
        }
        return incomeEntryArray
    }
    
    func getTwoWeeks() -> [BarChartDataEntry] {
        self.database = DatabaseHelper.postRequest()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var twoWeeksEntryArray = [BarChartDataEntry]()
        var paymentAmount :String?
        var incomeAmount :String?
        var calcuDate = Calendar.current.date(byAdding: .day, value: -13, to: Date())
        var xValue = 0
        
        for _ in 1...14 {
            let calculDate = formatter.string(from: calcuDate!)
            do{
                let stmt = try self.database.prepare("SELECT ifnull(sum(amount),0) as amount FROM input_detail where type_flag='0' and delete_flag='0' and create_time like '\(calculDate)%'")
                for row in stmt {
                    for (index, name) in stmt.columnNames.enumerated() {
                        if name == "amount" {
                            paymentAmount = String(describing: row[index]!)
                        }
                    }
                }
            }catch{
                print(error)
            }
            do{
                let stmt = try self.database.prepare("SELECT ifnull(sum(amount),0) as amount FROM input_detail where type_flag='1' and delete_flag='0' and create_time like '\(calculDate)%'")
                for row in stmt {
                    for (index, name) in stmt.columnNames.enumerated() {
                        if name == "amount" {
                            incomeAmount = String(describing: row[index]!)
                        }
                    }
                }
            }catch{
                print(error)
            }
            let result = Int(paymentAmount!)! + (-Int(incomeAmount!)!)
            if result != 0 {
            let entry = BarChartDataEntry(x: Double(xValue), y: (Double(paymentAmount!)! + (-Double(incomeAmount!)!)))
            twoWeeksEntryArray.append(entry)
            xValue = xValue + 1
            }
        calcuDate = Calendar.current.date(byAdding: .day, value: +1, to: calcuDate!)
        }
        
        return twoWeeksEntryArray
    }
}
