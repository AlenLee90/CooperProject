//
//  SecondViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/15.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON
import Alamofire

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
    
    var detailInputDetailModel = [InputDetail]()
    
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
    
    let baseApiTemp = BaseApi()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {    
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dict = ["id":String(segueData!)]
        let parameters: Parameters = [
            "id": dict["id"]!
        ]
        let url = URL(string: "http://127.0.0.1:8000/api/getViewDetail")
        baseApiTemp.baseApi(url: url!,paras: parameters as! [String : String], success: {
            (JSONResponse) -> Void in
            let json = JSON(JSONResponse)
            if json["status"].stringValue == "success" {
                self.locationLabel.text = "Location: "+json["data"][0]["location"].stringValue
                self.currencyLabel.text = "Currency: "+json["data"][0]["currency_id"].stringValue
                self.timeLabel.text = "Time: "+json["data"][0]["created_at"].stringValue
                self.typeLabel.text = "Category: "+json["data"][0]["category_id"].stringValue
                self.amountLabel.text = "Amount: "+json["data"][0]["amount"].stringValue
            } else {
                self.createAlert(title: "Fail", message: "Something wrong when loading api.")
            }
        }) {
            (error) -> Void in
            print(error)
        }
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.numberOfLines = 3
    }
    
    func createAlert (title:String, message:String){
        
        let alert = UIAlertController(title:title, message:message ,preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:{(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
