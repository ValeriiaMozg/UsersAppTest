//
//  UsersDataProvider.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation
import UIKit

class UsersDataProvider {
    
    private func userDisplayModel(_ user: User) -> UserDisplayModel {
        return UserDisplayModel(userId: randomString(length: 10), email: user.email ?? "", name: user.name?.firstname ?? "", lastname: user.name?.lastname ?? "", phone: user.phone ?? "", avatarLarge: user.picture?.large ?? "", avatarThumb: user.picture?.thumbnail ?? "", userPickedAvatar: nil)
    }
    
    private func userDisplayModel(_ userEntity: UserEntity) -> UserDisplayModel {
        
        var img: UIImage?
        if let data = userEntity.picture?.userLoadedAvatar {
            img = UIImage(data: data)
        }
        
        return UserDisplayModel(userId: userEntity.userId ?? "", email: userEntity.email ?? "", name: userEntity.firstname ?? "", lastname: userEntity.lastname ?? "", phone: userEntity.phone ?? "", avatarLarge: userEntity.picture?.large ?? "", avatarThumb: userEntity.picture?.thumbnail ?? "", userPickedAvatar: img)
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
}

extension UsersDataProvider: UsersListViewModelDataInput {
 
    func obtainUsers(_ page: Int?, seed: String?, obtainedInfo: @escaping (([UserDisplayModel], nextPage: Int, seed: String)) -> Void) {
        ApiClient().obtainUsers(page, seed: seed, info: { (users, page, seed) in
            
            var usersDisp = [UserDisplayModel]()
            
            for user in users {
                usersDisp.append(self.userDisplayModel(user))
            }
            
            obtainedInfo((usersDisp, page, seed))
            
        }) { (err) in
            
        }
    }
}

extension UsersDataProvider: EditProfileViewModelDataInput {
    
    func updatePhoto(_ photo: UIImage, forUser user: UserDisplayModel, completion: () -> Void) {
        
        user.userPickedAvatar = photo
        
        CoreDataManager.shared.updateAvatar(user)
        completion()
    }
    
    func saveUser(_ user: UserDisplayModel, completion: () -> Void) {
        CoreDataManager.shared.saveUser(user, completion: completion)
    }
}

extension UsersDataProvider: SavedUsersViewModelDataInput {
    
    func obtainSavedUsers() -> [UserDisplayModel]? {
        
        let userEntities = CoreDataManager.shared.fetchUsers()
        
        let userDisp = userEntities?.map({ (userEntity) -> UserDisplayModel in
            return userDisplayModel(userEntity)
        })
        
        return userDisp
    }
    
    func editUser(_ user: UserDisplayModel) {
        
        CoreDataManager.shared.saveUser(user) {
            
        }
    }
    
    func deleteUser(_ user: UserDisplayModel) {
        CoreDataManager.shared.deleteUser(user)
    }
    
    
}

