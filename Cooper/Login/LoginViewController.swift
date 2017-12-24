//
//  LoginViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/17.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let baseApiTemp = BaseApi()
    let loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let dict = ["name":name.text,"email":email.text, "password":password.text]
        let parameters: Parameters = [
            "name": dict["name"]!!,
            "email": dict["email"]!!,
            "password": dict["password"]!!
        ]
        let url = URL(string: "http://127.0.0.1:8000/api/login")
        baseApiTemp.baseApi(url: url!,paras: parameters as! [String : String], success: {
            (JSONResponse) -> Void in
            let json = JSON(JSONResponse)
            if json["status"].stringValue == "success" {
                self.baseApiTemp.saveToken(token: json["data"]["token"].stringValue,userId: json["data"]["user_id"].stringValue)
                self.present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController, animated: true, completion: nil)
            } else {
                self.createAlert(title: "Fail", message: "Wrong name or password or email.")
            }
        }) {
            (error) -> Void in
            print(error)
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
