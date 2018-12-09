//
//  CalendarDataSource.swift
//  EventCalendar
//
//  Created by kathelyss on 09/12/2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class CalendarDataSource {
    var models: [CalendarCellModel] = []
    
    let numberOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var date: Date = Date()
    
    let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru-RU")
        return calendar
    }()
    
    func dateAt(_ indexPath: IndexPath) -> Date? {
        let dateString = models[indexPath.row].title
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.dateFormat = "MM.YYYY"
        
        let resultString = dateString + "." + formatter.string(from: date)
        let nextFormatter = DateFormatter()
        nextFormatter.dateFormat = "dd.MM.YYYY"
        return nextFormatter.date(from: resultString)
    }
    
    func createModels(date: Date) {
        self.date = date
        var models: [CalendarCellModel] = []
        let firstMonthWeekDay = firstWeekDayOfMonth(date: date)
        for _ in 1..<firstMonthWeekDay {
            models.append(CalendarCellModel(title: ""))
        }
        let monthIndex = calendar.component(.month, from: date)
        for i in 1...numberOfDaysInMonth[monthIndex - 1] {
            models.append(CalendarCellModel(title: "\(i)"))
        }
        for _ in models.count...(7 * 6) {
            models.append(CalendarCellModel(title: ""))
        }
        self.models = models
    }

    private func firstWeekDayOfMonth(date: Date) -> Int {
        guard let interval = calendar.dateInterval(of: .month, for: date) else {
            print("Error!")
            return 0
        }
        let day = calendar.component(.weekday, from: interval.start)
        return day == 1 ? 7 : day - 1
    }
    
    func incrementMonth() {
        guard let date = calendar.date(byAdding: .month, value: 1, to: self.date) else { return }
        
        createModels(date: date)
    }
    
    func decrementMonth() {
        guard let date = calendar.date(byAdding: .month, value: -1, to: self.date) else { return }
        
        createModels(date: date)
    }
    
    func getMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.dateFormat = "LLLL YYYY"
        
        return formatter.string(from: date).capitalized
    }
}

