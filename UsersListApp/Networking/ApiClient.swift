//
//  ApiClient.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

let kBaseApi = "https://randomuser.me/api/"

class ListSerializer<T> where T: Mappable {
    class func serialize(jsonList: JSON) -> [T] {
        return jsonList.map({ T(JSON: $0.1.dictionaryObject!)! })
    }
}

class ApiClient {
    
    func obtainUsers(_ pageId: Int?, seed: String?, info: @escaping (([User], nextPage: Int, seed: String)) -> Void, err: @escaping (Error) -> Void) {
        
        var parameters = [String: Any]()
        
        if let page = pageId, let seed = seed {
           parameters["page"] = page
           parameters["seed"] = seed
        }
        
        parameters["results"] = 10
        
        Alamofire.request(kBaseApi, method: .get, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                 let usersList = ListSerializer<User>.serialize(jsonList: JSON(value)["results"])
                 
                 if let metaInfoJSON = JSON(value)["info"].dictionaryObject {
                    if let metaInfo = Mapper<MetaInfo>().map(JSONObject: metaInfoJSON) {
                        info((usersList, metaInfo.page ?? 0, metaInfo.seed ?? ""))
                    }
                 }
                
            case .failure(let error):
                err(error)
            }
        }
    }
}
