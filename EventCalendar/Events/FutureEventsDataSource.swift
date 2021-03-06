//
//  FutureEventsDataSource.swift
//  EventCalendar
//
//  Created by kathelyss on 10/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class FutureEventsDataSource {
    var models: [FutureEventCellModel] = []
    var filteredModels: [FutureEventCellModel] = []
    
    func createModels(from models: [EventModel]) {
        for model in models {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY mm:HH"
            self.models.append(FutureEventCellModel(ownerId: model.ownerId,
                                                    id: model.id,
                                                    eventTitle: model.name,
                                                    eventDetails: formatter.string(from: model.date ?? Date())))
        }
        filteredModels = self.models
    }
}
