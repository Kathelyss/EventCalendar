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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addFriendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        addFriendButton.setTitle("⊕", for: .normal)
        addFriendButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        addFriendButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        addFriendButton.contentHorizontalAlignment = .left
        addFriendButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addFriendButton)
        let editFriendListButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        editFriendListButton.setTitle("⋮", for: .normal)
        editFriendListButton.setTitleColor(#colorLiteral(red: 0.07649140192, green: 0.6212597551, blue: 0.6272005793, alpha: 1), for: .normal)
        editFriendListButton.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        editFriendListButton.contentHorizontalAlignment = .right
        editFriendListButton.addTarget(self, action: #selector(editFriendList), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editFriendListButton)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
