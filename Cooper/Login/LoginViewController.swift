//
//  LoginViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/17.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ButtonClick(_ sender: UIButton) {
                present( UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "tabBarIdentity") as UIViewController, animated: true, completion: nil)
    }
}
