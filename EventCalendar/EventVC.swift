//
//  EventVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var eventDateTextView: UITextField!
    @IBOutlet var eventTimeTextView: UITextField!
    @IBOutlet var eventDescriptionTextField: UITextView!
    @IBOutlet var eventButton: UIButton! //may be delete or subscribe button
    @IBOutlet var friendsButton: UIButton!
    
    var isMyEvent: Bool = true
    var isNewEvent: Bool = false
    var navigationTitle: String = "Детали события"
    
    var eventName: String = ""
    var details: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        containerView.addGestureRecognizer(tapRecognizer)
        
        setupDate()
        setupTime()
        eventNameTextField.text = eventName != "" ? eventName : ""
//        eventDateTextView.text = details
        navigationController?.title = navigationTitle
        
        addButtons()
    }
    
    private func setupDate() {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        picker.locale = Locale(identifier: "RU")
        picker.setDate(Date(), animated: false)
        dateChanged(picker)
        eventDateTextView.inputView = picker
    }
    
    private func setupTime() {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        picker.locale = Locale(identifier: "RU")
        timeChanged(picker)
        eventTimeTextView.inputView = picker
    }
    
    func addButtons() {
        friendsButton.layer.cornerRadius = 10
        friendsButton.layer.borderWidth = 1
        friendsButton.layer.borderColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1).cgColor
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        if isMyEvent {
            let editOrDoneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let title = isNewEvent ? "Готово" : "Править"
            editOrDoneButton.setTitle(title, for: .normal)
            editOrDoneButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
            editOrDoneButton.titleLabel?.font = UIFont(name: "System", size: 14)
            editOrDoneButton.contentHorizontalAlignment = .right
            if isNewEvent {
                editOrDoneButton.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
            } else {
                editOrDoneButton.addTarget(self, action: #selector(editEvent), for: .touchUpInside)
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editOrDoneButton)
        }
        
        if isMyEvent {
            eventButton.setTitle("Удалить событие", for: .normal)
            eventButton.layer.cornerRadius = 10
            eventButton.layer.borderWidth = 0
            eventButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        } else {
            eventButton.setTitle("Отметить участие", for: .normal)
            eventButton.layer.cornerRadius = 10
            eventButton.layer.borderWidth = 1
            eventButton.layer.borderColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1).cgColor
            eventButton.layer.backgroundColor = #colorLiteral(red: 0.1101291651, green: 0.8944641674, blue: 0.9030175209, alpha: 0.1).cgColor
        }
    }
    
    @objc
    func dateChanged(_ picker: UIDatePicker) {
        let date = picker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = Locale(identifier: "RU")
        eventDateTextView.text = formatter.string(from: date)
    }
    
    @objc
    func timeChanged(_ picker: UIDatePicker) {
        let date = picker.date
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "RU")
        eventTimeTextView.text = formatter.string(from: date)
    }
    
    @objc
    func close() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func createEvent() { //close view
        // send data
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func editEvent() {
        
    }
    
    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tapFriendsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToParticipantsVC", sender: self)
    }
    
    @IBAction func tapEventButton(_ sender: UIButton) {
        if !isMyEvent {
            performSegue(withIdentifier: "ToParticipationVC", sender: self)
        } else {
            //delete event
        }
    }
}
