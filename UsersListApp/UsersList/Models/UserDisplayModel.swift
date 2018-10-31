//
//  UserDisplayModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

struct UserDisplayModel {
    
    var email: String
    var name: String
    var lastname: String
    var phone: String
    var avatarLarge: String
    var avatarTrumb: String
    
    func editUserContent() -> [EditProfileCellObject] {
        
       let content = [EditProfileCellObject(title: "First Name", text: self.name),
                   EditProfileCellObject(title: "Last Name", text: self.lastname),
                   EditProfileCellObject(title: "Email", text: self.email),
                   EditProfileCellObject(title: "Phone", text: self.phone)]
        
        return content
    }
}
