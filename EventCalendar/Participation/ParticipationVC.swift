//
//  ParticipationVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ParticipationVC: UIViewController {
    @IBOutlet var willCome: UISwitch!
    @IBOutlet var maybeWillCome: UISwitch!
    @IBOutlet var maybeWillNotCome: UISwitch!
    @IBOutlet var willNotCome: UISwitch!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var switches: [UISwitch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switches.forEach {
            $0.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        }
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = CalendarStyle.borderWidth
        saveButton.layer.borderColor = CalendarStyle.borderAndTextColor
    }
    
    @objc
    func switchValueChanged(_ switche: UISwitch) {
        if switche.isOn {
            for swich in switches where swich != switche {
                swich.setOn(!switche.isOn, animated: true)
            }
        }
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        close()
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        var choice = ""
        if willCome.isOn {
            choice = "Приду"
        } else if maybeWillCome.isOn {
            choice = "Скорее приду"
        } else if maybeWillNotCome.isOn {
            choice = "Скорее не приду"
        } else if willNotCome.isOn {
            //не добавлять в участники
        }
        // send choice, add to participant model
        close()
    }
}
