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
    func editUser(_ user: UserDisplayModel)
    func deleteUser(_ user: UserDisplayModel)
}

protocol SavedUsersViewModelOutput: BaseViewModelOutput {
    func goToEditUser(_ user: UserDisplayModel)
}
