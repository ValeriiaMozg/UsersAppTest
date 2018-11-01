//
//  EditUserViewController.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeader: EditProfileHeader!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    private var user: UserDisplayModel?
    private var disposeBag = DisposeBag()

    lazy var dataProvider: UsersDataProvider = {
        return UsersDataProvider()
    }()
    
    lazy var viewModel: EditUserViewModel = {
        return EditUserViewModel(output: self, dataInput: dataProvider)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        binding()
        initialSetup()
        
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
    
        viewModel.saveUser() {
            navigationController?.popViewController(animated: true)
            tabBarController?.selectedIndex = 1
        }
    }
    
    private func initialSetup() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = tableHeader
        viewModel.headerInput = tableHeader
        
        tableView.register(UINib(nibName: "CellWithTextfield", bundle: nil), forCellReuseIdentifier: "CellWithTextfield")
    }
    
    private func binding() {
    
        viewModel.savingEnabled?
            .asObservable()
            .bind(to: saveBtn.rx.isEnabled).disposed(by: disposeBag)
    }

}

extension EditUserViewController: EditUserViewModelOutput {
    
    func addUserToSaved(_ user: UserDisplayModel) {
        
    }

    func reloadView() {
        tableView.reloadData()
    }
}
