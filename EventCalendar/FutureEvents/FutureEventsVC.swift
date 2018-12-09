//
//  FutureEventsVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class FutureEventsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let dataSource = FutureEventsDataSource()
    var navigationTitle: String = "Будущие события"
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtons()
        dataSource.createModels()
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let dateString = formatter.string(from: date)
            title = "События на " + dateString
        } else {
            title = navigationTitle
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventVC {
            vc.isMyEvent = false
            vc.isNewEvent = false
            vc.navigationTitle = "Детали события"
        }
    }
    
    func addButtons() {
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) // hidden when observe friend's calendar
        addEventButton.setTitle("⊕", for: .normal)
        addEventButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        addEventButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addEventButton.contentHorizontalAlignment = .right
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addEventButton)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc
    func addEvent() {
        performSegue(withIdentifier: "ToEventVC", sender: self)
    }
    
    @objc
    func close() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAllEventsButton(_ sender: UIButton) {
    }

    @IBAction func tapMyEventsButton(_ sender: UIButton) {
    }

    @IBAction func tapFriendsEventsButton(_ sender: UIButton) {
    }
}

extension FutureEventsVC: UITableViewDelegate {
    
}

extension FutureEventsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date == nil ? dataSource.allModels.count : dataSource.modelsForDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FutureEventCell", for: indexPath)
        
        if let cell = cell as? FutureEventCell {
            let model = date == nil ? dataSource.allModels[indexPath.row] : dataSource.modelsForDate[indexPath.row]
            cell.eventNameLabel.text = model.eventTitle
            cell.eventDetailsLabel.text = model.eventDetails
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToEventVC", sender: self)
    }
}
