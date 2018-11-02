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
    
    @IBAction func didClickChangePhoto(_ sender: UIButton) {
        
        let cameraAction = ("Camera", UIAlertAction.Style.default)
        let cameraRollAction = ("Camera Roll", UIAlertAction.Style.default)
        let cancelAction = ("Cancel", UIAlertAction.Style.cancel)
        
        showActionSheet(actions: [cameraAction, cameraRollAction, cancelAction], style: .actionSheet) { (action) in
            switch action.title {
            case "Camera"?:
                self.openCamera()
            case "Camera Roll"?:
                self.openCameraRoll()
            case "Cancel"?:
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    private func showActionSheet(title: String? = nil, message: String? = nil, actions: [(String, UIAlertAction.Style)], style: UIAlertController.Style, completion: @escaping (UIAlertAction) -> Void) {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for i in 0..<actions.count {
            let action = UIAlertAction(title: actions[i].0, style: actions[i].1, handler: completion)
            actionSheetController.addAction(action)
        }
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    
    private func openPicker(withSourceType sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self.viewModel
            imagePicker.sourceType = sourceType;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openCamera() {
        openPicker(withSourceType: .camera)
    }
    
    private func openCameraRoll() {
       openPicker(withSourceType: .photoLibrary)
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
            .bind(to: saveBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    }

}

extension EditUserViewController: EditUserViewModelOutput {
    
    func updateUserAvatar(_ avatar: UIImage) {
        tableHeader.profileImgView.image = avatar
    }

    func reloadView() {
        tableView.reloadData()
    }
}
