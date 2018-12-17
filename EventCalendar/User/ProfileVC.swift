//
//  ProfileVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = ""
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = CalendarStyle.borderWidth
        logoutButton.layer.borderColor = CalendarStyle.borderAndTextColor
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.borderWidth = CalendarStyle.borderWidth
        avatarImageView.layer.borderColor = CalendarStyle.borderAndTextColor
        
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        
        Services.shared.dao.login(name: name, success: { currentUser in
            DispatchQueue.main.async {
                self.nameLabel.text = currentUser.name
                // self.avatarImageView.image = currentUser.avatar
            }
        }) { error in
            
        }
    }

    @IBAction func tapLogoutButton(_ sender: UIButton) {
    }
}
