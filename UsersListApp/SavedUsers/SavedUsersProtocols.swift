//
//  SavedUsersViewModelDataInput.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 11/1/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

protocol SavedUsersViewModelDataInput: class {
    func obtainSavedUsers() -> [UserDisplayModel]?
}

protocol SavedUsersViewModelOutput: BaseViewModelOutput {
    
}

protocol SavedUsersViewModelInput: class {
//    func editUser(_)
}
