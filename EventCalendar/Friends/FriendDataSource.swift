//
//  FriendDataSource.swift
//  EventCalendar
//
//  Created by kathelyss on 10/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class FriendsDataSource {
    var models: [FriendCellModel] = []
    
    func createModels() {
        var models: [FriendCellModel] = []
        
        models.append(FriendCellModel(id: UUID(), name: "Иван Петров", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Петр Фёдоров", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Кристина Фролова", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Михаил Емельянов", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Анастасия Черных", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Ольга Клюшникова", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Елена Степанова", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Кузьма Подлодкин", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Андрей Кимрин", avatar: ""))
        models.append(FriendCellModel(id: UUID(), name: "Яков Шелест", avatar: ""))
        
        self.models = models
    }
}
