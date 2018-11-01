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
    
    private var isLoading = false
    private var lastLoadedIdxPath: IndexPath?
    private var nextPage: Int = 1
    private var seed: String = ""
    
    //MARK - Init
    init(dataInput: UsersListViewModelDataInput, output: UsersListViewModelOutput) {
        
        self.dataInput = dataInput
        self.output = output
        
        super.init()
        
        obtainContent()
    }
    
    //MARK: - Public
    func obtainContent(_ page: Int? = nil, seed: String? = nil) {
        
        dataInput.obtainUsers(page, seed: seed) { (users, obtainedPage, seed) in
            
            self.nextPage = obtainedPage
            self.seed     = seed
            
            self.isLoading = true

            if self.content.count == 0 {
                self.content  = users
                self.output?.reloadView()
            }
                
            else {
                
                let firstIdxToInsert = self.content.count
                let lastIdxToInsert = self.content.count + users.count
                
                self.content.append(contentsOf: users)
            
                var indexPaths = [IndexPath]()
                
                for idx in firstIdxToInsert..<lastIdxToInsert {
                    let indexPath = IndexPath(row: idx, section: 0)
                    indexPaths.append(indexPath)
                }
                
                self.output?.insertCells(at: indexPaths)
            }
        }
    }
}

extension UsersListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? content.count + 1 : content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath) {
            
            lastLoadedIdxPath = IndexPath(row: indexPath.row - 1, section: 0)
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        }
        else {
            guard let cell: UserTableCell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as? UserTableCell else {
                return UITableViewCell()
            }
            
            cell.configure(withUser: content[indexPath.row])
            
            return cell
        }
    }

    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard isLoading else { return false }
        return indexPath.row == content.count
    }
}

extension UsersListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        obtainContent()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = content[indexPath.row]
        output?.goToEditScreen(withUser: user)
    }
}
