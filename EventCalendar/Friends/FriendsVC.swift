//
//  FriendsVC.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let dataSource = FriendsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtons()
        dataSource.createModels()
    }
    
    func addButtons() {
        let addFriendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        addFriendButton.setTitle("⊕", for: .normal)
        addFriendButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        addFriendButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addFriendButton.contentHorizontalAlignment = .left
        addFriendButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addFriendButton)
        
        let editFriendListButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        editFriendListButton.setTitle("⋮", for: .normal)
        editFriendListButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        editFriendListButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        editFriendListButton.contentHorizontalAlignment = .right
        editFriendListButton.addTarget(self, action: #selector(editFriendList), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editFriendListButton)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddFriendVC {
            vc.onAddFriend = { [weak self] text in
                self?.dataSource.models.append(FriendCellModel(id: UUID(), name: text, avatar: ""))
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc
    func addFriend() {
        performSegue(withIdentifier: "ToAddFriendVC", sender: self)
    }
    
    @objc
    func editFriendList() {
        tableView.isEditing = !tableView.isEditing
    }
}

extension FriendsVC: UITableViewDelegate {
    
}

extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        
        if let cell = cell as? FriendCell {
            let model = dataSource.models[indexPath.row]
            cell.nameLabel.text = model.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.dataSource.models.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}
