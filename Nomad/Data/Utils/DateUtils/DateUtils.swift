//
//  DateUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DateUtils {
    class func stringFromDate(date: Date, dateStyle: DateFormatter.Style = DateFormatter.Style.medium, timeStyle: DateFormatter.Style = DateFormatter.Style.none, dateFormat: String? = nil) -> String {
        return dateFormatter(dateStyle: dateStyle, timeStyle: timeStyle, dateFormat: dateFormat).string(from: date)
    }
}

// MARK: - Private Methods

extension DateUtils {
    private class func dateFormatter(dateStyle: DateFormatter.Style = DateFormatter.Style.medium, timeStyle: DateFormatter.Style = DateFormatter.Style.none, dateFormat: String? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
