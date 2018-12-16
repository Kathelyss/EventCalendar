//
//  ServerDAO.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class ServerDAO {
    let server = ServerService()
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY hh:mm"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    func requestTest(success: @escaping (TestModel) -> Void, failure: @escaping (Error) -> Void) {
        server.getData(for: "json", success: { (data) in
            do {
                let testModel = try self.decoder.decode(TestModel.self, from: data)
                success(testModel)
            } catch {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func requestUser(success: @escaping (TestModel) -> Void, failure: @escaping (Error) -> Void) {
        server.getData(for: "getUser", success: { (data) in
            do {
                let testModel = try self.decoder.decode(TestModel.self, from: data)
                success(testModel)
            } catch {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
}
