//
//  SavedUsersViewController.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class SavedUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: SavedUsersViewModel = {
        return SavedUsersViewModel(output: self, dataInput: self.dataProvider)
    }()
    
    lazy var dataProvider: UsersDataProvider = {
        return UsersDataProvider()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        tableView.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: "UserTableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.obtainSavedUsers()
        
        tabBarController?.tabBar.isHidden = false
    }

}

extension SavedUsersViewController: SavedUsersViewModelOutput {
    
    func goToEditUser(_ user: UserDisplayModel) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EditUserViewController") as? EditUserViewController else { return }
        vc.configureWithUser(user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
