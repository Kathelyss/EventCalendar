//
//  Services.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class Services {
    static let shared: Services = Services()
    private init() {}
    
//    var currentUserId: UUID!
    
    let dao: DAO = FakeDAO() //
}
