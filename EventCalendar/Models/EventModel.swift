//
//  EventModel.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct EventModel: Decodable {
    let id: UUID
    let name: String
    let date: Date
    let description: String
    let participants: [UserModel]
    
}
