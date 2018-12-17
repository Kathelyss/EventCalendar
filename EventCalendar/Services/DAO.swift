//
//  DAO.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

protocol DAO {
    func requestTest(success: @escaping (TestModel) -> Void, failure: @escaping (Error) -> Void)
    func login(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
    func requestUser(userId: UUID, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
    func createUser(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func requestEvent(eventId: UUID, calendarId: UUID, success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void)
    func requestFutureEvents(userId: UUID, success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void)
    func createEvent(ownerId: UUID, calendarId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void)
//    func setSubscription(eventId: UUID, calendarId: UUID, userId: UUID, subscription: String,
//                         success: @escaping () -> Void, failure: @escaping (Error) -> Void)
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void)
}
