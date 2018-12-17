//
//  ParticipantDataSource.swift
//  EventCalendar
//
//  Created by kathelyss on 10/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class ParticipantsDataSource {
    var models: [ParticipantCellModel] = []
    var eventId: UUID!
    
    func createModels(completion: @escaping ()->Void) {
        Services.shared.dao.requestParticipants(eventId: eventId, success: { models in
            for model in models {
                self.models.append(ParticipantCellModel(id: model.id,
                                                        name: model.name,
                                                        avatar: model.avatar,
                                                        participation: "I'll go"))
            }
            completion()
        }) { error in
        }
    }
}
