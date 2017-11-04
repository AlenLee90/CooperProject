//
//  MasterViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/11/4.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet weak var oneContainer: UIView!
    @IBOutlet weak var twoContainer: UIView!
    
    @IBOutlet weak var segUi: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func segChange(_ sender: UISegmentedControl) {
//        self.storyboard?.instantiateViewController(withIdentifier: "report_navi") as! ReportViewController
//        self.storyboard?.instantiateViewController(withIdentifier: "twoWeeks_navi") as! TwoWeeksViewController
        switch segUi.selectedSegmentIndex {
        case 0:
            self.oneContainer.isHidden = false
            self.twoContainer.isHidden = true
            break
        case 1:
            self.oneContainer.isHidden = true
            self.twoContainer.isHidden = false
            break
        default:
            break
        }
    }
}
