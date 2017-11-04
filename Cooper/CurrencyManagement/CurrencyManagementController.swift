//
//  CurrencyManagementController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/29.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite

class CurrencyManagementController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var selectedDatas :AnySequence<Row>!
    
    let currencyManagementService = CurrencyManagementService()
    
    var labelArray = [String]()
    var statusArray = [Int]()
    var statusImage = [String]()
    var currencyIdArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: Selector(CurrencyManagementController.tappedBackButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectTableViewData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedDatas = currencyManagementService.selectCurrencyList()
        var count = 0
        for _ in selectedDatas {
            count = count + 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        selectedDatas = currencyManagementService.selectCurrencyList()
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyManagementCell
//        for data in selectedDatas {
//            labelArray.append(data[Expression<String>("currency_code")])
//            statusArray.append(data[Expression<Int>("status")])
//            currencyIdArray.append(data[Expression<Int>("currency_id")])
//        }
        cell.currencyCellLabel.text = labelArray[indexPath.row]
//
//        for status in statusArray {
//            if status == 1 {
//                statusImage.append("icons8-checkmark.png")
//            } else {
//                statusImage.append("icons8-blank.png")
//            }
//        }
        
        cell.currencyCellCheckImage.image =  UIImage(named: statusImage[indexPath.row])?.withRenderingMode(.alwaysOriginal) // deselect image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currencyManagementService.didSelectUpdate(currencyId: currencyIdArray[indexPath.row])
//        labelArray.removeAll()
//        statusArray.removeAll()
//        currencyIdArray.removeAll()
//        statusImage.removeAll()
//        selectTableViewData()
        self.dismiss(animated: true, completion: nil)
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "currencyVc")
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)

    }
    
    func navigationButtonClose(sender: UIBarButtonItem) {
        present( UIStoryboard(name: "Personal", bundle: nil).instantiateViewController(withIdentifier: "personal_nav") as! UINavigationController, animated: false, completion: nil)
    }
    
    func selectTableViewData() {
        selectedDatas = currencyManagementService.selectCurrencyList()
        for data in selectedDatas {
            labelArray.append(data[Expression<String>("currency_code")])
            statusArray.append(data[Expression<Int>("status")])
            currencyIdArray.append(data[Expression<Int>("currency_id")])
        }
        
        for status in statusArray {
            if status == 1 {
                statusImage.append("icons8-checkmark.png")
            } else {
                statusImage.append("icons8-blank.png")
            }
        }
    }
    
}

