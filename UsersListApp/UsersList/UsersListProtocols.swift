//
//  UsersListProtocols.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import Foundation

protocol UsersListViewModelDataInput: class {
    
    func obtainUsers(_ page: Int?, seed: String?, obtainedInfo:  @escaping (([UserDisplayModel], nextPage: Int, seed: String)) -> Void)
}

protocol UsersListViewModelOutput: class {
    func reloadView()
}

extension UsersListViewModelDataInput {
    
    func obtainUsers(_ page: Int? = nil, seed: String? = nil, obtainedInfo:  @escaping (([UserDisplayModel], nextPage: Int, seed: String)) -> Void) {
        obtainUsers(page, seed: seed, obtainedInfo: obtainedInfo)
    }
}
