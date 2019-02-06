//
//  ServerDAO.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class ServerDAO: DAO {    
    let server = ServerService()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY HH:mm"
        return formatter
    }()
    
    func login(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "user/get",
                      parameters: ["name": name],
                      success: success,
                      failure: failure)
    }
    
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "user/all",
                      parameters: ["userId": userId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }

    func addFriend(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "user/add",
                      parameters: ["name": name.capitalized],
                      success: success,
                      failure: failure)
    }
    
    func removeFriend(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "user/remove",
                      parameters: ["userId": userId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }

    func addEvent(calendarId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        let eventId = UUID() // on server ?
        serverGetData(endPoint: "event/post",
                      parameters: ["calendarId": calendarId.uuidString.lowercased(),
                                   "eventId": eventId.uuidString.lowercased(),
                                   "name": name,
                                   "date": formatter.string(from: date),
                                   "details": description],
                      success: success,
                      failure: failure)
    }
    
    func editEvent(calendarId: UUID, eventId: UUID, name: String, date: Date, description: String,
                   success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/edit",
                      parameters: ["calendarId": calendarId.uuidString.lowercased(),
                                   "eventId": eventId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }
    
    func removeEvent(calendarId: UUID, eventId: UUID, success: @escaping ([EventModel]) -> Void,
                     failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/remove",
                      parameters: ["calendarId": calendarId.uuidString.lowercased(),
                                   "eventId": eventId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }
    
    func requestAllEvents(success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/all",
                      parameters: nil,
                      success: success,
                      failure: failure)
    }
    
    func requestParticipants(eventId: UUID, success: @escaping ([UserModel]) -> Void,
                             failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/participants",
                      parameters: ["id": eventId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }
    
    func addParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void,
                        failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/participants/add",
                      parameters: ["id": eventId.uuidString.lowercased(),
                                   "userId": userId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }

    func removeParticipant(eventId: UUID, userId: UUID, success: @escaping ([UserModel]) -> Void,
                           failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "event/participants/remove",
                      parameters: ["id": eventId.uuidString.lowercased(),
                                   "userId": userId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }
    
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "calendar/get",
                      parameters: ["userId": userId.uuidString.lowercased()],
                      success: success,
                      failure: failure)
    }
    
    private func serverGetData<Type: Decodable>(endPoint: String, parameters: [String: String]?,
                                        success: @escaping (Type) -> Void, failure: @escaping (Error) -> Void) {
        server.getData(for: endPoint, parameters: parameters, success: { (data) in
            do {
                let model = try self.decoder.decode(Type.self, from: data)
                success(model)
            } catch {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
}
