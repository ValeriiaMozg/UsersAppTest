//
//  UserDisplayModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserDisplayModel {
    
    var email: String
    var name: String
    var lastname: String
    var phone: String
    var avatarLarge: String
    var avatarTrumb: String
    
    var editUserContent: [EditProfileCellObject] {
        return [EditProfileCellObject(title: "First Name", text: Variable(self.name), cellType: .name),
                EditProfileCellObject(title: "Last Name", text: Variable(self.lastname), cellType: .name),
                EditProfileCellObject(title: "Email", text: Variable(self.email), cellType: .email),
                EditProfileCellObject(title: "Phone", text: Variable(self.phone), cellType: .phone)]
    }
    
    init(email: String, name: String, lastname: String, phone: String, avatarLarge: String, avatarThumb: String) {
        self.email = email
        self.name  = name
        self.lastname = lastname
        self.phone = phone
        self.avatarLarge = avatarLarge
        self.avatarTrumb = avatarThumb
    }
}
