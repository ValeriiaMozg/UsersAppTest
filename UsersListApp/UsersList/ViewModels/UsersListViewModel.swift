//
//  UsersListViewModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class UsersListViewModel: NSObject {
    
    var content = [UserDisplayModel]()
    
    unowned let dataInput: UsersListViewModelDataInput
    weak var output: UsersListViewModelOutput?
    
    private var lastLoadedIdxPath: IndexPath?
    private var nextPage: Int = 1
    private var seed: String = ""
    
    func obtainContent() {
        
        dataInput.obtainUsers { (users, page, seed) in
            self.content  = users
            self.output?.reloadView()
        }
    }
    
    init(dataInput: UsersListViewModelDataInput, output: UsersListViewModelOutput) {
        
        self.dataInput = dataInput
        self.output = output
        
        super.init()

        obtainContent()
    }
}

extension UsersListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: UserTableCell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as? UserTableCell else {
            return UITableViewCell()
        }
        
        cell.configure(withUser: content[indexPath.row])
        
        return cell
    }
}

extension UsersListViewModel: UITableViewDelegate {
    
}
