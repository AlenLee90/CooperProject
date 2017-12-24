//
//  InputDataController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/16.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation
import SwiftyJSON
import Alamofire

class InputDataController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var segUi: UISegmentedControl!
    @IBOutlet weak var amountOfMoney: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var inputButton: UIButton!
    
    let manager = CLLocationManager()
    var database: Connection!
    let categoryTable = Table("common_category")
    let currency = ["Food","Drink","Game","Clothes"]
    let categoryName = Expression<String>("category_name")
    
    struct pickerStruct {
        var categoryId: Int
        var categoryName: String
    }
    var pickerData = [pickerStruct]()
    
    var categoryId: Int?
    
    var latitude :Double?
    var longitude :Double?
    var myLocation :CLLocationCoordinate2D?
    var location :String?
    
    let inputDataService = InputDataService()
    let currencyService = CurrencyManagementService()
    let loginService = LoginService()
    var inputDetailModel :InputDetail?
    var currencyCode :String?
    var currencyId :String?
    let baseApiTemp = BaseApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        segUi.apportionsSegmentWidthsByContent = true
        
        for pickerList in inputDataService.selectPickerList(){
            pickerData.append(pickerStruct(categoryId: pickerList[Expression<Int>("category_id")],categoryName: pickerList[Expression<String>("category_name")]))
        }
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.currencyCode = currencyService.selectCurrencyCode()
        self.currencyId = currencyService.selectCurrencyId(currencyCode: self.currencyCode!)
        var attributedString :NSAttributedString?
        let myRange = NSRange(location: 10, length: (currencyCode?.count)!)
        currencyCode = "Currency: " + currencyCode!
        let myMutableString = NSMutableAttributedString(
            string: currencyCode!,
            attributes: [:])
        myMutableString.addAttribute(
            NSAttributedStringKey.foregroundColor,
            value: UIColor.red,
            range: myRange)
        attributedString = myMutableString
        currencyLabel.attributedText = attributedString
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let valueSelected = pickerData[row].categoryName as String
        for temp in pickerData {
            if temp.categoryName == valueSelected {
                categoryId = temp.categoryId
            }
        }
        return pickerData[row].categoryName
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    @IBAction func insertData(_ sender: UIButton) {
        var errorFlag :Bool = false
        if (amountOfMoney.text?.isEmpty)! {
            createAlert(title: "Attention", message: "You do not input amount!")
            errorFlag = true
        }
        if errorFlag == false {

            let user_id = inputDataService.getUserId()
            let dict = ["user_id":String(user_id), "amount":String(Int(amountOfMoney.text!)!),"category_id":String(categoryId!), "consumption_flag":String(segUi.selectedSegmentIndex), "currency_id":self.currencyId!, "location":location!]
            let parameters: Parameters = [
                "user_id": dict["user_id"]!,
                "amount": dict["amount"]!,
                "category_id": dict["category_id"]!,
                "consumption_flag": dict["consumption_flag"]!,
                "currency_id": dict["currency_id"]!,
                "location": dict["location"]!
            ]
            let url = URL(string: "http://127.0.0.1:8000/api/updateInputDetail")
            baseApiTemp.baseApi(url: url!,paras: parameters as! [String : String], success: {
                (JSONResponse) -> Void in
                let json = JSON(JSONResponse)
                print(JSONResponse)
                if json["status"].stringValue == "success" {
                    self.amountOfMoney.text! = ""
                    self.createAlert(title: "Succeed", message: "You have inserted the data!")
                } else {
                    self.createAlert(title: "Fail", message: "You fail to inserted the data!")
                }
            }) {
                (error) -> Void in
                print(error)
            }
        
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let valueSelected = pickerData[row].categoryName as String
        for temp in pickerData {
            if temp.categoryName == valueSelected {
                categoryId = temp.categoryId
            }
        }
    }
    
    func createAlert (title:String, message:String){
        
        let alert = UIAlertController(title:title, message:message ,preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:{(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        reverseGeocode()
    }
    
    //地理信息反编码
    func reverseGeocode(){
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude!, longitude: longitude!)
        print("hey hey \(currentLocation)")
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if let p = placemarks?[0]{
                var address = ""
                if let country = p.country {
                    address.append("\(country),")
                }
                if let locality = p.locality {
                    address.append("\(locality),")
                }
                if let subLocality = p.subLocality {
                    address.append("\(subLocality)")
                }
                self.location = address
            } else {
                print("No placemarks!")
            }
        })
    }

}
