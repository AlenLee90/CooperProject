//
//  AppDelegate.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/14.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var database : Connection!
    
    let currencyTable = Table("currencies")
    let currencyId = Expression<Int>("currency_id")
    let currencyCode = Expression<String>("currency_code")
    let categoryTable = Table("categories")
    let categoryId = Expression<Int>("category_id")
    let categoryName = Expression<String>("category_name")
    let status = Expression<Int>("status")
    let tokenTable = Table("access_token")
    let id = Expression<Int>("id")
    let userId = Expression<Int>("user_id")
    let token = Expression<String>("token")
    let deleteFlag = Expression<Int>("delete_flag")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        do{
//        self.database = DatabaseHelper.postRequest()
//        try self.database.run(currencyTable.addColumn(Expression<Int?>("status")))
//        let updateData = self.currencyTable.filter(self.deleteFlag == 0)
//        let updateQuery = updateData.update( Expression<Int>("status") <- 0)
//        try self.database.run(updateQuery)
//        let updateDataTwo = self.currencyTable.filter(self.deleteFlag == 0 && self.currencyCode == "USD")
//        let updateQueryTwo = updateDataTwo.update( Expression<Int>("status") <- 1)
//        try self.database.run(updateQueryTwo)
//        }catch{
//            print(error)
//        }
        
        // 得到当前应用的版本号
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 取出之前保存的版本号
        let userDefaults = UserDefaults.standard
        let appVersion = userDefaults.string(forKey: "appVersion")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 第一次启动创建数据库
        if appVersion == nil {
            self.database = DatabaseHelper.postRequest()
            
            let createCurrencyTable = self.currencyTable.create{(table) in
                table.column(self.currencyId,primaryKey:true)
                table.column(self.currencyCode)
                table.column(self.status)
                table.column(self.deleteFlag)
            }
            
            let createCategoryTable = self.categoryTable.create{(table) in
                table.column(self.categoryId,primaryKey:true)
                table.column(self.categoryName)
                table.column(self.deleteFlag)
            }
            
            let createTokenTable = self.tokenTable.create{(table) in
                table.column(self.id,primaryKey:true)
                table.column(self.userId)
                table.column(self.token)
            }
            
            do{
                try self.database.run(createCurrencyTable)
                print("Created Currency Table")
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
                try self.database.run(createTokenTable)
                print("Created Token Table")
            }catch{
                print(error)
            }
            
            let categoryData = ["Shopping", "Food", "Traffic"]
            
            for item in categoryData {
                let insertData = self.categoryTable.insert(self.categoryName <- item,self.deleteFlag <- 0)
                
                do{
                    try self.database.run(insertData)
                    print("Inserted Data")
                }catch{
                    print(error)
                }
            }
            
            let currencyData = ["USD", "GBP", "EUR", "CAD", "CHN", "JPY"]
            
            for item in currencyData {
                let insertData = self.currencyTable.insert(self.currencyCode <- item,self.deleteFlag <- 0,self.status <- 0)
                
                do{
                    try self.database.run(insertData)
                    print("Inserted Data")
                }catch{
                    print(error)
                }
            }
            
        }
        
        // 如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
        if appVersion == nil || appVersion != currentAppVersion {
            
            // 保存最新的版本号
            userDefaults.setValue(currentAppVersion, forKey: "appVersion")
            print("first excute")

            
        }
        
        let guideViewController = storyboard.instantiateViewController(withIdentifier: "GuideViewController") as! GuideViewController
        self.window?.rootViewController = guideViewController
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

