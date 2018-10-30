//
//  UserModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var gender: String?
    var name: Name?
    var email: String?
    var picture: Picture?
    var phone: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        gender <- map["gender"]
        name <- map["name"]
        email <- map["email"]
        picture <- map["picture"]
        phone <- map["phone"]
    }
}

class Name: Mappable {
    
    var firstname: String?
    var lastname: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        firstname <- map["first"]
        lastname <- map["last"]
    }
}

class Picture: Mappable {
    
    var large: String?
    var medium: String?
    var thumbnail: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        large <- map["large"]
        medium <- map["medium"]
        thumbnail <- map["thumbnail"]
    }
}

class MetaInfo: Mappable {
    
    var seed: String?
    var page: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        seed <- map["seed"]
        page <- map["page"]
    }
}
