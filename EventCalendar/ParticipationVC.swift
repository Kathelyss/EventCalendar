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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = #colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1).cgColor
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        close()
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        // send data
        close()
    }
}
