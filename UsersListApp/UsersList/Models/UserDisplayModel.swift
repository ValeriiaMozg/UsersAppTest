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
    
    var userId: String
    
    var email: String
    var name: String
    var lastname: String
    var phone: String
    var avatarLarge: String
    var avatarTrumb: String
    var userPickedAvatar: UIImage?
    
    var editUserContent: [EditProfileCellObject] {
        return [EditProfileCellObject(title: "First Name", text: Variable(self.name), cellType: .name),
                EditProfileCellObject(title: "Last Name", text: Variable(self.lastname), cellType: .name),
                EditProfileCellObject(title: "Email", text: Variable(self.email), cellType: .email),
                EditProfileCellObject(title: "Phone", text: Variable(self.phone), cellType: .phone)]
    }
    
    init(userId: String, email: String, name: String, lastname: String, phone: String, avatarLarge: String, avatarThumb: String, userPickedAvatar: UIImage?) {
        
        self.userId = userId
        
        self.email = email
        self.name  = name
        self.lastname = lastname
        self.phone = phone
        self.avatarLarge = avatarLarge
        self.avatarTrumb = avatarThumb
        self.userPickedAvatar = userPickedAvatar
    }
}
