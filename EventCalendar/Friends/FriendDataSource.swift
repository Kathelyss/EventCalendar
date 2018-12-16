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
        Services.shared.dao.requestFriends(userId: UUID(), success: { models in
            for model in models {
                self.models.append(FriendCellModel(id: model.id,
                                                   name: model.name,
                                                   avatar: model.avatar))
            }
        }) { error in
        }
        
    }
}
