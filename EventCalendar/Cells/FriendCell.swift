//
//  FriendCell.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
