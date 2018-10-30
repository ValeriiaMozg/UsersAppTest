//
//  UsersDataProvider.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

class UsersDataProvider {
    
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
    
    private func userDisplayModel(_ user: User) -> UserDisplayModel {
        return UserDisplayModel(email: user.email ?? "", name: user.name?.firstname ?? "", lastname: user.name?.lastname ?? "", phone: user.phone ?? "", avatarLarge: user.picture?.large ?? "", avatarTrumb: user.picture?.thumbnail ?? "")
    }
}
