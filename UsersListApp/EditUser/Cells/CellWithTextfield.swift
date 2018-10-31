//
//  CellWithTextfield.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class CellWithTextfield: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        textField.delegate = self
    }

    func configure(withObj cellObj: EditProfileCellObject) {
        nameLabel.text = cellObj.title
        textField.text = cellObj.text
    }
}

extension CellWithTextfield: UITextFieldDelegate {
    
}
