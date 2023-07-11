//
//  Date+Extension.swift
//  PetFinder
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import Foundation

extension Date {
    static func dateCreator(year: Int, month: Int, day: Int) -> Date {
        var component: DateComponents = DateComponents()
        component.calendar = .current
        component.year = year
        component.month = month
        component.day = day
        return Calendar.current.date(from: component)!
    }

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameWeek(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .weekOfYear)
    }

    func isInSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }

    var toString: String {
        return self.formatted(date: .long, time: .omitted)
    }
}
