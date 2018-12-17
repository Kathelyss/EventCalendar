//
//  DAO.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

protocol DAO {
    func login(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
//    func requestUser(userId: UUID, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
//    func createUser(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func createEvent(calendarId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void)

    func requestAllEvents(success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void)
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void)
    func requestParticipants(eventId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func addParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func removeParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
}
