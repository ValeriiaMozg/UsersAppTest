//
//  SavedUsersViewModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 11/1/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class SavedUsersViewModel: NSObject {

    weak var output: SavedUsersViewModelOutput?
    unowned let dataInput: SavedUsersViewModelDataInput
    
    private var content = [UserDisplayModel]()
    
    init(output: SavedUsersViewModelOutput, dataInput: SavedUsersViewModelDataInput) {
        self.output = output
        self.dataInput = dataInput
    }
    
    func obtainSavedUsers() {
        
        if let users =  dataInput.obtainSavedUsers() {
            content = users
            output?.reloadView()
        }
    }
}

extension SavedUsersViewModel: UITableViewDataSource {
    
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

extension SavedUsersViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            tableView.beginUpdates()
            
            let usrToRemove = content[indexPath.row]

            dataInput.deleteUser(usrToRemove)
            content.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        output?.goToEditUser(content[indexPath.row])
    }
}
