//
//  ParticipantsVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ParticipantsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
   
    @objc
    func close() {
        navigationController?.popViewController(animated: true)
    }
}

extension ParticipantsVC: UITableViewDelegate {
    
}

extension ParticipantsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
