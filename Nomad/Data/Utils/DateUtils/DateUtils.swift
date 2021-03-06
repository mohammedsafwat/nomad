//
//  DateUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DateUtils: DateUtilsProtocol {
    func stringFromDate(date: Date, dateStyle: DateFormatter.Style = DateFormatter.Style.medium, timeStyle: DateFormatter.Style = DateFormatter.Style.none, dateFormat: String? = nil) -> String {
        return dateFormatter(dateStyle: dateStyle, timeStyle: timeStyle, dateFormat: dateFormat).string(from: date)
    }

    func weekendDateStrings(travelInterval: TravelInterval) -> (String, String) {
        switch travelInterval {
        case .thisWeekend:
            return (Date().thisWeekendDates(format: Constants.GeneralProperties.dateFormat).0,
                    Date().thisWeekendDates(format: Constants.GeneralProperties.dateFormat).1)
        case .nextWeekend:
            return (Date().nextWeekendDates(format: Constants.GeneralProperties.dateFormat).0,
                    Date().nextWeekendDates(format: Constants.GeneralProperties.dateFormat).1)
        case .theWeekendAfter:
            return (Date().nextTwoWeekendsDates(format: Constants.GeneralProperties.dateFormat).0,
                    Date().nextTwoWeekendsDates(format: Constants.GeneralProperties.dateFormat).1)
        case .undefined:
            return (stringFromDate(date: Date()), stringFromDate(date: Date()))
        }
    }

    func formattedTravelInterval(travelInterval: TravelInterval) -> String {
        return String(format: "%@ - %@", weekendDateStrings(travelInterval: travelInterval).0, weekendDateStrings(travelInterval: travelInterval).1)
    }

    func hoursDifference(date1: Date, date2: Date) -> Int {
        if let diff = Calendar.current.dateComponents([.hour], from: date1, to: date2).hour {
            return diff
        }
        return 0
    }
}

// MARK: - Private Methods

extension DateUtils {
    private func dateFormatter(dateStyle: DateFormatter.Style = DateFormatter.Style.medium, timeStyle: DateFormatter.Style = DateFormatter.Style.none, dateFormat: String? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
