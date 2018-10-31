//
//  UserTableCell.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/30/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit
import SDWebImage

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
        avatarImgView.sd_setImage(with: URL(string: user.avatarTrumb))
        let username = user.name + " " + user.lastname
        nameLabel.text = username.capitalized
        phoneLabel.text = user.phone
    }
}
