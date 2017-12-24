//
//  File.swift
//  Cooper
//
//  Created by 李亚男 on 2017/12/22.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SQLite

class BaseApi{
    
//    func login(paras : [String:String]){
//        let url = URL(string: "http://127.0.0.1:8000/api/login")
//        var temp:JSON?
//        baseApi(url: url!,paras: paras, success: {
//            (JSONResponse) -> Void in
//        }) {
//            (error) -> Void in
//            print(error)
//        }
//        print("BaseApi3333")
//
//    }
    
//    class func register(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/register")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func getViewDatas(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/getViewDatas")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func getViewDetail(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/getViewDetail")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func updateViewDetail(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/updateViewDetail")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func deleteViewData(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/deleteViewData")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func getChartTodaySum(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/getChartTodaySum")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func getChartRec14DaysDatas(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/getChartRec14DaysDatas")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func getChartRec3MonsDatas(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/getChartRec3MonsDatas")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
//
//    class func updateInputDetail(paras : [String:String]) -> JSON {
//        let url = URL(string: "http://127.0.0.1:8000/api/updateInputDetail")
//        baseApi(url: url!,paras: paras)
//        return self.json
//    }
    
    func baseApi(url : URL,paras : Parameters, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        let url = URL(string: "http://127.0.0.1:8000/api/login")
        
//        let toke = getToken()
        
        var headers: HTTPHeaders = [:]
        
//        if !toke.isEmpty {
//            headers = [
//                "Authorization": "Basic "+toke,
//                "Accept": "application/json"
//            ]
//        }
        
        Alamofire.request(url!, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: headers).responseJSON {(responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
            
            }
    }
    
    func getToken() -> String {
        let database : Connection! = DatabaseHelper.postRequest()
        var result :String?
        do{
            for acTok in try database.prepare(Table("access_token")) {
                result = acTok[Expression<String?>("token")]
            }
        }catch{
            print(error)
        }
        return result!
    }
    
    func saveToken(token : String) {
        let database : Connection! = DatabaseHelper.postRequest()
        do{
            try database.run(Table("access_token").insert(
                Expression<String?>("token") <- token
            ))
        }catch{
            print(error)
        }
    }
}
