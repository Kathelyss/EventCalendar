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
    
    func createModels(completion: @escaping ()->Void) {
        guard let idString = UserDefaults.standard.string(forKey: "id"),
            let id = UUID.init(uuidString: idString) else { return }
        
        Services.shared.dao.requestFriends(userId: id, success: { models in
            for model in models {
                self.models.append(FriendCellModel(id: model.id,
                                                   name: model.name,
                                                   avatar: model.avatar))
            }
            completion()
        }) { error in
        }
        
    }
}
