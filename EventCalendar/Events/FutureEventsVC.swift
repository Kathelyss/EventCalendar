//
//  FutureEventsVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

enum Filter {
    case mine, friends, all
}

class FutureEventsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let dataSource = FutureEventsDataSource()
    var navigationTitle: String = "Будущие события"
    var date: Date?
    var events: [EventModel] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtons()
        dataSource.createModels(from: events)
        tableView.reloadData()
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
            //            vc.navigationTitle = "Детали события"
            if let model = sender as? FutureEventCellModel {
                vc.eventName = model.eventTitle
                vc.eventId = model.id
                //                vc.details = model.eventDetails
            }
        }
    }
    
    func addButtons() {
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        addEventButton.setTitle("⊕", for: .normal)
        addEventButton.setTitleColor(#colorLiteral(red: 0.2300778031, green: 0.5918118954, blue: 0.828825593, alpha: 1), for: .normal)
        addEventButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addEventButton.contentHorizontalAlignment = .right
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addEventButton)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.2300778031, green: 0.5918118954, blue: 0.828825593, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "System", size: 14)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func filterEvents(criteria: Filter) {
        // filter Events for choosen Date!
        
        let eventsList = dataSource.models
        guard let myId = UserDefaults.standard.string(forKey: "name")?.lowercased() else {
            print("Oops, can not get myId [Future EventsVC]")
            return
        }

        switch criteria {
        case .mine:
            dataSource.filteredModels = eventsList.filter { $0.ownerId.uuidString.lowercased() == myId }
            break
        case .friends:
            dataSource.filteredModels = eventsList.filter { $0.ownerId.uuidString.lowercased() != myId }
            break
        case .all:
            dataSource.filteredModels = dataSource.models
            break
        default:
            print("Oops, can not filter Events [Future EventsVC]")
            dataSource.filteredModels = dataSource.models
            break
        }
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
        filterEvents(criteria: .all)
    }
    
    @IBAction func tapMyEventsButton(_ sender: UIButton) {
        filterEvents(criteria: .mine)
    }
    
    @IBAction func tapFriendsEventsButton(_ sender: UIButton) {
        filterEvents(criteria: .friends)
    }
}

extension FutureEventsVC: UITableViewDelegate {
    
}

extension FutureEventsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.filteredModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FutureEventCell", for: indexPath)
        
        if let cell = cell as? FutureEventCell {
            let model = dataSource.filteredModels[indexPath.row]
            cell.eventNameLabel.text = model.eventTitle
            cell.eventDetailsLabel.text = model.eventDetails
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource.filteredModels[indexPath.row]
        performSegue(withIdentifier: "ToEventVC", sender: model)
    }
}
