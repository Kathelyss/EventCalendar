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
        formatter.dateFormat = "dd-MM-YYYY hh:mm"
        return formatter
    }()
    
    func requestTest(success: @escaping (TestModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "json",
                      parameters: nil,
                      success: success,
                      failure: failure)
    }
    
    func login(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "login",
                      parameters: ["name": name],
                      success: success,
                      failure: failure)
    }
    
    func requestUser(userId: UUID, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "getUser",
                      parameters: ["userId": userId.uuidString],
                      success: success,
                      failure: failure)
    }
    
    func createUser(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "postUser",
                      parameters: ["name": name],
                      success: success,
                      failure: failure)
    }
    
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "user/all",
                      parameters: ["userId": userId.uuidString],
                      success: success,
                      failure: failure)
    }
    
    func requestEvent(eventId: UUID, success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "getEvent",
                      parameters: ["eventId": eventId.uuidString],
                      success: success,
                      failure: failure)
    }
    
    func requestFutureEvents(userId: UUID, success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "getFutureEvents",
                      parameters: ["userId": userId.uuidString],
                      success: success,
                      failure: failure)
    }
    
    func createEvent(ownerId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "postEvent",
                      parameters: ["ownerId": ownerId.uuidString,
                                   "name": name,
                                   "date": formatter.string(from: date),
                                   "description": description],
                      success: success,
                      failure: failure)
    }
    
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void) {
        serverGetData(endPoint: "getCalendar",
                      parameters: ["userId": userId.uuidString],
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

class FakeDAO: DAO {
    func requestTest(success: @escaping (TestModel) -> Void, failure: @escaping (Error) -> Void) {
        
    }
    
    
    func login(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        success(UserModel(id: UUID(), name: name, avatar: "0_0"))
    }
    
    func requestUser(userId: UUID, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        success(UserModel(id: UUID(), name: "Екатерина Рыжова", avatar: "0_0"))
    }
    
    func createUser(name: String, success: @escaping (UserModel) -> Void, failure: @escaping (Error) -> Void) {
        success(UserModel(id: UUID(), name: name, avatar: "0_0"))
    }
    
    func requestFriends(userId: UUID, success: @escaping ([UserModel]) -> Void, failure: @escaping (Error) -> Void) {
        var models: [UserModel] = []
        models.append(UserModel(id: UUID(), name: "Иван Петров", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Петр Фёдоров", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Кристина Фролова", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Михаил Емельянов", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Анастасия Черных", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Ольга Клюшникова", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Елена Степанова", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Кузьма Подлодкин", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Андрей Кимрин", avatar: "0_0"))
        models.append(UserModel(id: UUID(), name: "Яков Шелест", avatar: "0_0"))
        success(models)
    }
    
    func requestEvent(eventId: UUID, success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        success(EventModel(id: UUID(),
                           name: "Имя события",
                           date: Date(),
                           description: "Описание события",
                           participants: []))
    }
    
    func requestFutureEvents(userId: UUID, success: @escaping ([EventModel]) -> Void, failure: @escaping (Error) -> Void) {
        var models: [EventModel] = []
        models.append(EventModel(id: UUID(), name: "Поход к ортодонту", date: Date(), description: "Зубья всему голова",
                                 participants: []))
        models.append(EventModel(id: UUID(), name: "Занятие йогой", date: Date(), description: "В три погибели",
                                 participants: []))
        models.append(EventModel(id: UUID(), name: "Поездка в аквапарк", date: Date(), description: "Буль-буль-карасики",
                                 participants: []))
        models.append(EventModel(id: UUID(), name: "Верховая прогулка", date: Date(),
                                 description: "Верхом на звездеее\nНавстречу ветрааам\nИ создал этот мииииир\nЯ саааам!",
                                 participants: []))
        success(models)
    }
    
    func createEvent(ownerId: UUID, name: String, date: Date, description: String,
                     success: @escaping (EventModel) -> Void, failure: @escaping (Error) -> Void) {
        success(EventModel(id: UUID(), name: name, date: date, description: description, participants: []))
    }
    
    func requestCalendar(userId: UUID, success: @escaping (CalendarModel) -> Void, failure: @escaping (Error) -> Void) {
        success(CalendarModel(id: UUID(), userId: userId, events: []))
    }
}
