    //
//  ViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/14.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let inputDetailTable = Table("input_detail")
    
    var labelOneArray = [String]()
    var labelTwoArray = [NSAttributedString]()
    var labelThreeArray = [String]()
    var labelFourArray = [String]()
    
    let id = Expression<Int>("id")
    let deleteFlag = Expression<Int>("delete_flag")
    
    var selectedDatas :AnySequence<Row>!
    
    let viewService = ViewService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedDatas = viewService.selectTableData()
        var counter = 0
        for _ in selectedDatas{
            counter += 1
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        selectedDatas = viewService.selectTableData()

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        for selectedData in selectedDatas{
            var tempAmount = String(selectedData[Expression<Int>("amount")])
            var tempTwoAmout :NSAttributedString?
            if selectedData[Expression<Int>("type_flag")] == 0 {
                tempAmount = "-"+tempAmount
                let text = tempAmount
                let nsText = text as NSString
                let textRange = NSMakeRange(0, nsText.length)
                let myMutableString = NSMutableAttributedString(
                    string: tempAmount,
                    attributes: [:])
                myMutableString.addAttribute(
                    NSAttributedStringKey.foregroundColor,
                    value: UIColor.red,
                    range: textRange)
                tempTwoAmout = myMutableString
            } else {
                tempAmount = "+"+tempAmount
                
                let text = tempAmount
                let nsText = text as NSString
                let textRange = NSMakeRange(0, nsText.length)
                
                let myMutableString = NSMutableAttributedString(
                    string: tempAmount,
                    attributes: [:])
                myMutableString.addAttribute(
                    NSAttributedStringKey.foregroundColor,
                    value: UIColor.green,
                    range: textRange)
                tempTwoAmout = myMutableString
            }
            labelOneArray.append(String(selectedData[Expression<Int>("id")]))
            labelTwoArray.append(tempTwoAmout!)
            labelThreeArray.append(String(selectedData[Expression<String>("location")]))
            labelFourArray.append(String(describing: selectedData[Expression<Date>("create_time")]))
        }
        cell.labelOne.text = labelOneArray[indexPath.row]
        cell.labelTwo.attributedText = labelTwoArray[indexPath.row]
        cell.labelThree.text = labelThreeArray[indexPath.row]
        cell.labelFour.text = labelFourArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OneToSecondSegue", sender: labelOneArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! SecondViewController
        guest.segueData = sender as? String
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let updateData = self.inputDetailTable.filter(self.id == Int(labelOneArray[indexPath.row])!)
        let updateQuery = updateData.update(self.deleteFlag <- 1)
        let alert = UIAlertController(title:"Confirm", message:"Are you sure to delete the date?" ,preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"Yes", style:UIAlertActionStyle.default, handler:{(action) in
            self.labelOneArray.remove(at: indexPath.row)
            self.labelTwoArray.remove(at: indexPath.row)
            self.labelThreeArray.remove(at: indexPath.row)
            self.labelFourArray.remove(at: indexPath.row)
            
            if self.viewService.deleteTableData(updateQuery: updateQuery) == true {
                self.createAlert(title: "Succeed", message: "Deleted the data!")
            } else {
                self.createAlert(title: "Failed", message: "Fail to delete data!")
            }
            alert.dismiss(animated: true, completion: nil)
            tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title:"No", style:UIAlertActionStyle.default, handler:{(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        if editingStyle == .delete {
                self.present(alert, animated: true, completion: nil)
                tableView.reloadData()
        }
    }
    
    func createAlert (title:String, message:String){
        
        let alert = UIAlertController(title:title, message:message ,preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:{(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}

