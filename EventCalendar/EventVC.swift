//
//  EventVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var eventDateTextField: UIDatePicker!
    @IBOutlet var eventTimeTextField: UIDatePicker!
    @IBOutlet var eventDescriptionTextField: UITextView!
    @IBOutlet var eventButton: UIButton! //may be delete or subscribe button
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapFriendsButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEventButton(_ sender: UIButton) {
    }
}
