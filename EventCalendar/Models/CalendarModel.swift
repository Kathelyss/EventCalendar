//
//  CalendarModel.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct CalendarModel: Decodable {
    let id: UUID
    let userId: UUID
    let events: [EventModel]
    
}
