//
//  TestModel.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct TestModel: Decodable {
    let disk: Disk
    let temperature: String
    let time: String

}

struct Disk: Decodable {
    let total: String
    let remaining: String
    let used: String

}
