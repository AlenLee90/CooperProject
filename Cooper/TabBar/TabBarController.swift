//
//  TabBarController.swift
//
//  Created by 李亚男 on 2017/10/22.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取两个Tab对应的 Storyboard
        let story_first = UIStoryboard(name:"View",bundle:nil)
        let story_second = UIStoryboard(name:"InputData",bundle:nil)
        let story_personal = UIStoryboard(name:"Personal",bundle:nil)
        let story_report = UIStoryboard(name:"Report",bundle:nil)
        
        // 获取对应的 ViewController
        let view_nav_viewcontroller = story_first.instantiateViewController(withIdentifier: "view_nav") as! UINavigationController
        let input_data_nav_viewcontroller = story_second.instantiateViewController(withIdentifier: "input_data_nav") as! UINavigationController
        let personal_nav_viewcontroller = story_personal.instantiateViewController(withIdentifier: "personal_nav") as! UINavigationController
        let report_nav_viewcontroller = story_report.instantiateViewController(withIdentifier: "report_nav") as! UINavigationController
        
        // 设置 tabBar 内容
        view_nav_viewcontroller.tabBarItem = UITabBarItem(title:"Detail",image:nil,tag:1)
        input_data_nav_viewcontroller.tabBarItem = UITabBarItem(title:"Input",image:nil,tag:0)
        personal_nav_viewcontroller.tabBarItem = UITabBarItem(title:"Personal",image:nil,tag:3)
        report_nav_viewcontroller.tabBarItem = UITabBarItem(title:"Report",image:nil,tag:2)
        input_data_nav_viewcontroller.tabBarItem.image=UIImage(named: "icons8-enter_pin.png")?.withRenderingMode(.alwaysOriginal) // deselect image
        input_data_nav_viewcontroller.tabBarItem.selectedImage = UIImage(named: "icons8-enter_pin.png")?.withRenderingMode(.alwaysOriginal) // select image
        view_nav_viewcontroller.tabBarItem.image=UIImage(named: "icons8-show_property.png")?.withRenderingMode(.alwaysOriginal) // deselect image
        view_nav_viewcontroller.tabBarItem.selectedImage = UIImage(named: "icons8-show_property.png")?.withRenderingMode(.alwaysOriginal) // select image
        report_nav_viewcontroller.tabBarItem.image=UIImage(named: "icons8-futures_filled.png")?.withRenderingMode(.alwaysOriginal) // deselect image
        report_nav_viewcontroller.tabBarItem.selectedImage = UIImage(named: "icons8-futures_filled.png")?.withRenderingMode(.alwaysOriginal) // select image
        personal_nav_viewcontroller.tabBarItem.image=UIImage(named: "icons8-settings_filled.png")?.withRenderingMode(.alwaysOriginal) // deselect image
        personal_nav_viewcontroller.tabBarItem.selectedImage = UIImage(named: "icons8-settings_filled.png")?.withRenderingMode(.alwaysOriginal) // select image
        
        self.viewControllers = [input_data_nav_viewcontroller,view_nav_viewcontroller,report_nav_viewcontroller,personal_nav_viewcontroller]
        
        //Connect two controller without segue method
        //@IBAction func ButtonClick(_ sender: UIButton) {
        //present( UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "tabBarIdentity") as UIViewController, animated: true, completion: nil)
        //}
    }

}
