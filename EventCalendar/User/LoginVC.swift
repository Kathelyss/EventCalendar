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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapRecognizer)
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = CalendarStyle.borderWidth
        loginButton.layer.borderColor = CalendarStyle.borderAndTextColor
    }
    
    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        
        if UserDefaults.standard.string(forKey: "name") == nil {
            Services.shared.dao.login(name: name, success: { currentUser in
                DispatchQueue.main.async {
                    let id = currentUser.id.uuidString
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.synchronize()
                }
            }) { error in
                
            }
            performSegue(withIdentifier: "ToCalendarVC", sender: self)
        } else {
            performSegue(withIdentifier: "ToCalendarVC", sender: self)
        }
    }
    
    @IBAction func unwindToLoginVC(segue: UIStoryboardSegue) {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "id")
    }
}
