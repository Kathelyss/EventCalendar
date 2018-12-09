//
//  AddFriendVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class AddFriendVC: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var friendNameTextField: UITextField!
    @IBOutlet var addFriendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        containerView.addGestureRecognizer(tapRecognizer)
        addFriendButton.layer.cornerRadius = 10
        addFriendButton.layer.borderWidth = 1
        addFriendButton.layer.borderColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1).cgColor
    }

    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAddFriendButton(_ sender: UIButton) {
        close()
    }
}
