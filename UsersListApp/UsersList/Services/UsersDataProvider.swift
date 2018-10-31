//
//  UsersDataProvider.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

class UsersDataProvider {
    
    private func userDisplayModel(_ user: User) -> UserDisplayModel {
        return UserDisplayModel(email: user.email ?? "", name: user.name?.firstname ?? "", lastname: user.name?.lastname ?? "", phone: user.phone ?? "", avatarLarge: user.picture?.large ?? "", avatarTrumb: user.picture?.thumbnail ?? "")
    }
    
    private func userDisplayModel(_ userEntity: UserEntity) -> UserDisplayModel {
        return UserDisplayModel(email: userEntity.email ?? "", name: userEntity.firstname ?? "", lastname: userEntity.lastname ?? "", phone: userEntity.phone ?? "", avatarLarge: userEntity.picture?.large ?? "", avatarTrumb: userEntity.picture?.thumbnail ?? "")
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
    
    func saveUser(_ user: UserDisplayModel, completion: () -> Void) {
        CoreDataManager.shared.saveUser(user, completion: completion)
    }
    
//    func saveUser(_ user: UserDisplayModel, savedUser: (UserDisplayModel) -> Void) {
//        CoreDataManager.shared.saveUser(user)
//
//        if let svUser = CoreDataManager.shared.fetchUser(byEmail: user.email) {
//            savedUser(userDisplayModel(svUser))
//        }
//    }
}
