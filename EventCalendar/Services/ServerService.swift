//
//  ServerService.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

/**
 Service to interoperate with the server fetching all UI related information
 */
final class ServerService: NSObject {
    @objc dynamic private(set)var timestamp: Int64 = 0
    
    lazy private var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(20)
        config.timeoutIntervalForResource = TimeInterval(60)
        return URLSession(configuration: config)
    }()
    
    // swiftlint:disable:next function_body_length
    func getData(for string: String,
                 parameters: [String: String]? = nil,
                 success: @escaping (Data) -> Void,
                 failure: @escaping (Error) -> Void) {
        
        guard let url = URLBuilder().url(for: string, parameters: parameters) else {
            fatalError("Couldn't create URL")
        }
        
        var request = URLRequest(url: url)
        //        log(url.absoluteString, type: .serverURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, responseBody, error in
//            self.printAsString(data: data)
//            print(String(describing: error))
            if let data = data {
                success(data)
            } else if let error = error {
                failure(error)
            }
        }
        task.resume()
    }
    
    private func printAsString(data: Data?) {
        guard let data = data else { return }
        
        if let string = try? JSONSerialization.jsonObject(with: data, options: []) {
            print(string)
        }
    }
    
}
