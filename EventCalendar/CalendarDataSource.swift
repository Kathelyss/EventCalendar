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
    
    let calendar = Calendar.current
    
    func createModels(date: Date) {
        self.date = date
        var models: [CalendarCellModel] = []
        let firstMonthWeekDay = firstWeekDayOfMonth(date: date)
        for _ in 0..<firstMonthWeekDay - 2 {
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
        
        return interval.start.weekDay
    }
    
    func incrementMonth() {
        guard let date = calendar.date(byAdding: .month, value: 1, to: self.date) else { return }
        
        createModels(date: date)
    }
    
    func decrementMonth() {
        guard let date = calendar.date(byAdding: .month, value: -1, to: self.date) else { return }
        
        createModels(date: date)
    }
}

// allows to get first day of month
extension Date {
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}

