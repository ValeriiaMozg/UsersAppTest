//
//  EditUserViewController.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeader: EditProfileHeader!
    
    private var user: UserDisplayModel?
    
    lazy var dataProvider: UsersDataProvider = {
        return UsersDataProvider()
    }()
    
    lazy var viewModel: EditUserViewModel = {
        return EditUserViewModel(output: self, dataInput: dataProvider)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        binding()
        
        if let user = user {
            viewModel.configure(withUser: user)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func configureWithUser(_ user: UserDisplayModel) {
        self.user = user
    }
    
    
    @IBAction func didClickSave(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        viewModel.saveUser() {
            tabBarController?.selectedIndex = 1
        }
    }
    
    private func binding() {
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = tableHeader
        viewModel.headerInput = tableHeader
        
        tableView.register(UINib(nibName: "CellWithTextfield", bundle: nil), forCellReuseIdentifier: "CellWithTextfield")
    }

}

extension EditUserViewController: EditUserViewModelOutput {
    
    func addUserToSaved(_ user: UserDisplayModel) {
        
    }

    func reloadView() {
        tableView.reloadData()
    }
}
