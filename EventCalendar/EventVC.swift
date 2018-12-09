//
//  EventVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var eventDateTextField: UIDatePicker!
    @IBOutlet var eventTimeTextField: UIDatePicker!
    @IBOutlet var eventDescriptionTextField: UITextView!
    @IBOutlet var eventButton: UIButton! //may be delete or subscribe button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        containerView.addGestureRecognizer(tapRecognizer)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let editOrDoneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        editOrDoneButton.setTitle("Готово", for: .normal) //видна, если мое событие
//        editOrDoneButton.setTitle("Править", for: .normal) //видна, если мое событие
        editOrDoneButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        editOrDoneButton.titleLabel?.font = UIFont(name: "System", size: 14)
        editOrDoneButton.contentHorizontalAlignment = .right
        editOrDoneButton.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
//        editOrDoneButton.addTarget(self, action: #selector(editEvent), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editOrDoneButton)

    }
    
    @objc
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func createEvent() { //close view
        // send data
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func editEvent() {
        
    }
    
    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }

    @IBAction func tapFriendsButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEventButton(_ sender: UIButton) {
    }
}
