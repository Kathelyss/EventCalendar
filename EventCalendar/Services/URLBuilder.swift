//
//  URLBuilder.swift
//  EventCalendar
//
//  Created by kathelyss on 16/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import CoreGraphics
import Foundation

class URLBuilder {
    let isLocalServer = true
    let siteURL: String = "http://217.71.226.120"
    
    func url(for string: String, parameters: [String: String]?) -> URL? {
        var urlComponents = URLComponents(string: urlString(string: string))
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
//                guard let key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//                    let value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//                        continue
//                }
                
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents?.queryItems = queryItems
        }
        return urlComponents?.url
    }
    
    func urlString(string: String) -> String {
        if string.hasPrefix(siteURL) {
            return string
        }
        if string.hasPrefix("/") {
            return siteURL + string
        }
        return siteURL + "/" + string
    }
    
    func url(string: String) -> URL? {
        return URL(string: urlString(string: string))
    }
    
}
