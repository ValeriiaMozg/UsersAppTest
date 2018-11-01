//
//  CellWithTextfield.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit
import RxSwift

class CellWithTextfield: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: ValidatingTextField!
    
    private let throttleInterval = 0.1
    var disposeBag = DisposeBag()

    var cellObject: EditProfileCellObject? {
        didSet {
            nameLabel.text = cellObject?.title
            textField.text = cellObject?.text.value
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
}
