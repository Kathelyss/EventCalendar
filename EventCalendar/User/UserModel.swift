//
//  UserModel.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    let id: UUID
    let calendarId: UUID
    let name: String
    let avatar: String
    
}
