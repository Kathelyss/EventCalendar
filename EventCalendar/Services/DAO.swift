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
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func addFriend(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void)
    func removeFriend(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func addEvent(calendarId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void)
    func editEvent(calendarId: UUID, eventId: UUID, name: String, date: Date, description: String,
                   success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void)
    func removeEvent(calendarId: UUID, eventId: UUID, success: @escaping ([EventModel]) -> Void,
                     failure: @escaping (Error) -> Void)
    func requestAllEvents(success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void)
    func requestParticipants(eventId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func addParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func removeParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void)
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void)
}
