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
    
    func goToEditScreen(withUser user: UserDisplayModel) {
        
        guard let editUserVC = storyboard?.instantiateViewController(withIdentifier: "EditUserViewController") as? EditUserViewController else { return }
        editUserVC.configureWithUser(user)
        navigationController?.pushViewController(editUserVC, animated: true)
    }
    
    func insertCells(at indexPaths: [IndexPath]) {
        
        UIView.setAnimationsEnabled(false)
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .fade)
        tableView.endUpdates()
        
        UIView.setAnimationsEnabled(true)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

