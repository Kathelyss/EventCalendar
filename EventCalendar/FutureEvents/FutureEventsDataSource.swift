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
        
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход к ортодонту", eventDetails: Date()))
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "День рождения Жени", eventDetails: Date()))
        modelsForDate.append(FutureEventCellModel(id: UUID(), eventTitle: "Йога", eventDetails: Date()))
        
        self.modelsForDate = modelsForDate
        
        var allModels: [FutureEventCellModel] = []
        
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход к ортодонту", eventDetails: Date()))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "День рождения Жени", eventDetails: Date()))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Йога", eventDetails: Date()))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Зачёт по экономике", eventDetails: Date()))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Поход в аквапарк", eventDetails: Date()))
        allModels.append(FutureEventCellModel(id: UUID(), eventTitle: "Верховая прогулка", eventDetails: Date()))
        
        self.allModels = allModels
    }
}
