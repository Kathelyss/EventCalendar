//
//  FutureEventsDataSource.swift
//  EventCalendar
//
//  Created by kathelyss on 10/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class FutureEventsDataSource {
    var modelsForDate: [FutureEventCellModel] = []
    var allModels: [FutureEventCellModel] = []
    
    func createModels() {
        var modelsForDate: [FutureEventCellModel] = []
        
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход к ортодонту", eventDetails: "10.00"))
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "День рождения Жени", eventDetails: "13.00"))
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "Йога", eventDetails: "20.00"))
        
        self.modelsForDate = modelsForDate
        
        var allModels: [FutureEventCellModel] = []
        
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход к ортодонту", eventDetails: "19.12.2018"))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "День рождения Жени", eventDetails: "19.12.2018"))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Йога", eventDetails: "19.12.2018"))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Зачёт по экономике", eventDetails: "25.12.2018"))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход в аквапарк", eventDetails: "30.01.2019"))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Верховая прогулка", eventDetails: "10.02.2019"))
        
        self.allModels = allModels
    }
}
