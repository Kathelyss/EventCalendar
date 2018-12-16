//
//  LoginVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapRecognizer)
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = CalendarStyle.borderWidth
        loginButton.layer.borderColor = CalendarStyle.borderAndTextColor
    }
    
    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        
        //if user exists, login
        Services.shared.dao.login(name: name, success: { currentUser in
//            Services.shared.currentUserId = currentUser.id
        }) { error in
            
        }
        //else create user
        Services.shared.dao.createUser(name: name, success: { currentUser in
//            Services.shared.currentUserId = currentUser.id
        }) { error in
            
        }
    }
}
