//
//  ViewController.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    lazy var viewModel: UsersListViewModel = {
        return UsersListViewModel(dataInput: self.dataProvider, output: self)
    }()
    
    lazy var dataProvider: UsersDataProvider = {
        return UsersDataProvider()
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        tableView.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: "UserTableCell")
    }
}

extension UsersListViewController: UsersListViewModelOutput {
    
    func reloadView() {
        tableView.reloadData()
    }
}

