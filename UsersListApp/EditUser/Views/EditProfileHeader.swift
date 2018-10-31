//
//  EditProfileHeader.swift
//  UsersListApp
//
//  Created by Lera Mozgovaya on 10/31/18.
//  Copyright © 2018 Lera Mozgovaya. All rights reserved.
//

import UIKit

class EditProfileHeader: UIView {

    @IBOutlet weak var profileImgView: UIImageView!

    @IBAction func didClickChangePhoto(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.layer.cornerRadius = profileImgView.frame.width / 2
    }
}

extension EditProfileHeader: EditProfileHeaderInput {
    
    func configure(withUser user: UserDisplayModel) {
        profileImgView.sd_setImage(with: URL(string: user.avatarLarge))
    }
}
