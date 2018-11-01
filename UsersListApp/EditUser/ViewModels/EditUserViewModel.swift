//
//  EditUserViewModel.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditUserViewModel: NSObject {

    private var user: UserDisplayModel?
    weak var output: EditUserViewModelOutput?
    var content = [EditProfileCellObject]()
    weak var headerInput: EditProfileHeaderInput?
    unowned let dataInput: EditProfileViewModelDataInput
    
    var savingEnabled: Observable<Bool>?
    
    var nameValid: Observable<Bool>?
    var emailValid: Observable<Bool>?
    var phoneValid: Observable<Bool>?
    
    init(output: EditUserViewModelOutput, dataInput: EditProfileViewModelDataInput) {
        
        self.output = output
        self.dataInput = dataInput
    }
    
    func configure(withUser user: UserDisplayModel) {
        
        self.user = user
        
        content = user.editUserContent
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
        
        let item = content[indexPath.row]
        cell.cellObject = item
 
        setupTextChangeHandling(cell)
        
        return cell
    }
}

extension EditUserViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension EditUserViewModel {

    private func setupTextChangeHandling(_ cell: CellWithTextfield) {

        guard let cellObject = cell.cellObject else { return }
        
        switch cellObject.cellType {
        case .name:
            nameValid = cell.textField
            .rx
            .text
            .throttle(0.1, scheduler: MainScheduler.instance)
                .map { self.validate(text: $0, for: cellObject)
            }
        
            nameValid?.subscribe(onNext: {
                cell.textField.valid = $0
                
                
                
            }).disposed(by: cell.disposeBag)
            

        case .email:
            emailValid = cell.textField
                .rx
            .text
            .throttle(0.1, scheduler: MainScheduler.instance)
                .map { self.validateEmail($0)}

            emailValid?.subscribe(onNext: {
                cell.textField.valid = $0
            }).disposed(by: cell.disposeBag)
            
        case .phone:
            phoneValid = cell.textField
            .rx
            .text
                .throttle(0.1, scheduler: MainScheduler.instance)
                .map({ self.validatePhone($0) })
            
            phoneValid?.subscribe(onNext: {
                cell.textField.valid = $0
            }).disposed(by: cell.disposeBag)
        }
        
        guard let nv = nameValid, let ev = emailValid else {
            return
        }
        
        savingEnabled = Observable
            .combineLatest(nv, ev) { $0 && $1 }
    }
    
    func validate(text: String?, for cellObj: EditProfileCellObject) -> Bool {
        
        guard let text = text else { return false }
        let isValidText = ((text.count > 0 && text.count <= 30) && !text.containsWhitespace)
        
        cellObj.text.value = text
        
        if cellObj.title == "First Name" {
            self.user?.name = cellObj.text.value
        }
        else {
            self.user?.lastname = cellObj.text.value
        }
        
        return isValidText
    }
    
    func validateEmail(_ email: String?) -> Bool {
        
        guard let email = email else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let isValid = email.isEmpty == false && emailTest.evaluate(with: email)
        
        return isValid
    }
    
    func validatePhone(_ phone: String?) -> Bool {
        
        guard let phone = phone else { return false }
        
        let numbersOnly = CharacterSet(charactersIn: "0123456789")
        let enteredText = CharacterSet(charactersIn: phone)
        
        let isValid = numbersOnly.isSuperset(of: enteredText)
        return isValid
    }
}

extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}

class ValidatingTextField: UITextField {
    
    var valid: Bool = false {
        didSet {
            configureForValid()
        }
    }
    
    var hasBeenExited: Bool = false {
        didSet {
            configureForValid()
        }
    }
    
    func commonInit() {
        configureForValid()
    }
    
    //Yeah, totally required.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func resignFirstResponder() -> Bool {
        hasBeenExited = true
        return super.resignFirstResponder()
    }
    
    private func configureForValid() {
        
        self.layer.borderWidth = 0.5
        
        if !valid && hasBeenExited {
            //Only color the background if the user has tried to
            //input things at least once.
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

