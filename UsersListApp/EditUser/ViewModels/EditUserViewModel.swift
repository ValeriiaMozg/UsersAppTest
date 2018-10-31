//
//  EditUserViewModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class EditUserViewModel: NSObject {

    private var user: UserDisplayModel?
    weak var output: EditUserViewModelOutput?
    var content = [EditProfileCellObject]()
    weak var headerInput: EditProfileHeaderInput?
    unowned let dataInput: EditProfileViewModelDataInput
    
    init(output: EditUserViewModelOutput, dataInput: EditProfileViewModelDataInput) {
        
        self.output = output
        self.dataInput = dataInput
    }
    
    func configure(withUser user: UserDisplayModel) {
        
        self.user = user
        
        content = user.editUserContent()
        headerInput?.configure(withUser: user)
        
        output?.reloadView()
    }
    
    func saveUser(_ completion: () -> Void) {
        
        guard let user = user else { return }
        dataInput.saveUser(user, completion: completion)
    }
}

extension EditUserViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithTextfield", for: indexPath) as? CellWithTextfield else {
            return UITableViewCell()
        }
        
        cell.configure(withObj: content[indexPath.row])
        
        return cell
    }
}

extension EditUserViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
