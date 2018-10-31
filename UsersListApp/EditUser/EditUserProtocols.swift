//
//  EditUserViewModelOutput.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

protocol EditUserViewModelOutput: BaseViewModelOutput {
    func addUserToSaved(_ user: UserDisplayModel)
}

protocol EditProfileHeaderInput: class {
    func configure(withUser user: UserDisplayModel)
}

protocol EditProfileViewModelDataInput: class {
    
    func saveUser(_ user: UserDisplayModel, completion: () -> Void)
}
