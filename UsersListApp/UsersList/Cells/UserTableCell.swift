//
//  UserTableCell.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImgView.layer.cornerRadius = avatarImgView.frame.width / 2
    }

    func configure(withUser user: UserDisplayModel) {
//        avatarImgView.image =
        nameLabel.text = user.name + user.lastname
        phoneLabel.text = user.phone
    }
}
