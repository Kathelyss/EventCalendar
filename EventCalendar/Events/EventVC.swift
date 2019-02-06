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
//    var navigationTitle: String = "Детали события"
    
    var eventName: String = ""
    var details: Date = Date()
    var participants: [UserModel] = []
    var eventId: UUID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDescriptionTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        containerView.addGestureRecognizer(tapRecognizer)
        
        setupDate()
        setupTime()
        eventNameTextField.text = eventName != "" ? eventName : ""
//        eventDateTextView.text = details
//        navigationController?.title = navigationTitle
        
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
        friendsButton.layer.cornerRadius = 5
        friendsButton.layer.borderWidth = CalendarStyle.borderWidth
        friendsButton.layer.borderColor = CalendarStyle.borderAndTextColor
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.2300778031, green: 0.5918118954, blue: 0.828825593, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        if isMyEvent {
            let editOrDoneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let title = isNewEvent ? "Готово" : "Править"
            editOrDoneButton.setTitle(title, for: .normal)
            editOrDoneButton.setTitleColor(#colorLiteral(red: 0.2300778031, green: 0.5918118954, blue: 0.828825593, alpha: 1), for: .normal)
            editOrDoneButton.titleLabel?.font = UIFont(name: "System", size: 14)
            editOrDoneButton.contentHorizontalAlignment = .right
            if isNewEvent {
                //show empty event
                editOrDoneButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
                eventButton.isHidden = true
                friendsButton.isHidden = true
            } else {
//                guard let idString = UserDefaults.standard.string(forKey: "id"),
//                    let id = UUID.init(uuidString: idString) else { return }
//                
//                Services.shared.dao.requestCalendar(userId: id, success: { calendar in
//                    self.eventNameTextField.text = calendar.events.name
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "dd.MM.YYYY"
//                    self.eventDateTextView.text = formatter.string(from: eventModel.date)
//                    formatter.dateFormat = "mm:HH"
//                    self.eventTimeTextView.text = formatter.string(from: eventModel.date)
//                    self.eventDescriptionTextField.text = eventModel.description
//                    self.participants = eventModel.participants
//                }) { error in
//                }
                editOrDoneButton.addTarget(self, action: #selector(editEvent), for: .touchUpInside)
                eventButton.isHidden = false
                friendsButton.isHidden = false
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editOrDoneButton)
        }
        
        if isMyEvent {
            eventButton.setTitle("Удалить событие", for: .normal)
            eventButton.layer.cornerRadius = 5
            eventButton.layer.borderWidth = 0
            eventButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        } else {
            eventButton.setTitle("Отметить участие", for: .normal)
            eventButton.layer.cornerRadius = 5
            eventButton.layer.borderWidth = CalendarStyle.borderWidth
            eventButton.layer.borderColor = CalendarStyle.borderAndTextColor
            eventButton.layer.backgroundColor = #colorLiteral(red: 0.2300778031, green: 0.5918118954, blue: 0.828825593, alpha: 0.1).cgColor
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
    func addEvent() {
        guard let name = eventNameTextField.text,
            let date = eventDateTextView.text,
            let time = eventTimeTextView.text,
            let description = eventDescriptionTextField.text else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let dateFromString = formatter.date(from: date)
//        formatter.dateFormat = "mm:HH"
        let timeFromString = formatter.date(from: time)
//        date.add(timeFromString)
        guard let calendarString = UserDefaults.standard.string(forKey: "calendar_id"),
            let calendarId = UUID.init(uuidString: calendarString) else { return }
        
        Services.shared.dao.addEvent(calendarId: calendarId,
                                        name: name,
                                        date: dateFromString ?? Date(),
                                        description: description,
                                        success: { eventModel in
                
         }) { error in
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func editEvent() {
        
    }
    
    @objc
    func closeKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ParticipantsVC {
            vc.eventId = self.eventId
        }
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
