//
//  EditUserViewModelOutput.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import UIKit

protocol EditUserViewModelOutput: BaseViewModelOutput {
    func updateUserAvatar(_ avatar: UIImage)
}

protocol EditProfileHeaderInput: class {
    func configure(withUser user: UserDisplayModel)
}

protocol EditProfileViewModelDataInput: class {
    
    func saveUser(_ user: UserDisplayModel, completion: () -> Void)
    func updatePhoto(_ photo: UIImage, forUser user: UserDisplayModel, completion: () -> Void)
}
