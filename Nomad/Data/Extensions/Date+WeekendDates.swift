//
//  Date+WeekendDates.swift
//  Nomad
//
//  Created by Mohammed Safwat on 28.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

extension Date {

    // Public Methods
    
    func thisWeekendDates(format: String) -> (String, String) {
        let thisFriday = weekDates().thisWeek[weekDates().thisWeek.count - 3].toDate(format: format)
        let thisSunday = weekDates().thisWeek[weekDates().thisWeek.count - 1].toDate(format: format)
        return (thisFriday, thisSunday)
    }

    func nextWeekendDates(format: String) -> (String, String) {
        let nextFriday = weekDates().nextWeek[weekDates().nextWeek.count - 3].toDate(format: format)
        let nextSunday = weekDates().nextWeek[weekDates().nextWeek.count - 1].toDate(format: format)
        return (nextFriday, nextSunday)
    }

    func nextTwoWeekendsDates(format: String) -> (String, String) {
        let nextTwoFridays = weekDates().nextTwoWeeks[weekDates().nextTwoWeeks.count - 3].toDate(format: format)
        let nextTwoSundays = weekDates().nextTwoWeeks[weekDates().nextTwoWeeks.count - 1].toDate(format: format)
        return (nextTwoFridays, nextTwoSundays)
    }

    // Private Methods and Properties

    private func weekDates() -> (thisWeek: [Date], nextWeek: [Date], nextTwoWeeks: [Date]) {
        var thisWeek: [Date] = []
        for i in 0..<7 {
            guard let startOfWeek = startOfWeek,
                let weekDate = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)
                else { continue }
            thisWeek.append(weekDate)
        }

        var nextWeek: [Date] = []
        for i in 1...7 {
            guard let thisWeekLastDate = thisWeek.last else { continue }
            if let nextWeekDate = Calendar.current.date(byAdding: .day, value: i, to: thisWeekLastDate) {
                nextWeek.append(nextWeekDate)
            }
        }

        var nextTwoWeeks: [Date] = []
        for i in 1...7 {
            guard let nexWeekLastDate = nextWeek.last else { continue }
            if let nextTwoWeeksDate = Calendar.current.date(byAdding: .day, value: i, to: nexWeekLastDate) {
                nextTwoWeeks.append(nextTwoWeeksDate)
            }
        }

        return (thisWeek: thisWeek, nextWeek: nextWeek, nextTwoWeeks: nextTwoWeeks)
    }

    private func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    private var tomorrow: Date? {
        guard let noon = noon else { return nil }
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)
    }

    private var noon: Date? {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)
    }

    private var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
}
