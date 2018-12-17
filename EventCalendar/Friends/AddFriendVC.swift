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
    
    var onAddFriend:((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        containerView.addGestureRecognizer(tapRecognizer)
        
        addFriendButton.layer.cornerRadius = 5
        addFriendButton.layer.borderWidth = CalendarStyle.borderWidth
        addFriendButton.layer.borderColor = CalendarStyle.borderAndTextColor
    }

    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAddFriendButton(_ sender: UIButton) {
        onAddFriend?(friendNameTextField.text ?? "")
        
        close()
    }
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        close()
    }
}
