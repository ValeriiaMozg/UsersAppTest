//
//  EditProfileCellObject.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EditProfileCellObject {
    
    enum EditProfileCellType {
        case name
        case email
        case phone
    }
    
    var title: String
    var text: Variable<String>
    var cellType: EditProfileCellType
    
    init(title: String, text: Variable<String>, cellType: EditProfileCellType) {
        self.title = title
        self.text = text
        self.cellType = cellType
    }
}
