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
    
    func createModels() {
        var models: [ParticipantCellModel] = []
        
        models.append(ParticipantCellModel(id: UUID(), name: "Яков Шелест", avatar: "", participation: "Скорее не приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Кузьма Подлодкин", avatar: "", participation: "Приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Кристина Фролова", avatar: "", participation: "Скорее приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Михаил Емельянов", avatar: "", participation: "Приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Елена Степанова", avatar: "", participation: "Приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Иван Петров", avatar: "", participation: "Скорее не приду"))
        models.append(ParticipantCellModel(id: UUID(), name: "Андрей Кимрин", avatar: "", participation: "Скорее приду"))
        
        self.models = models
    }
}
