//
//  DateUtilsProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

protocol DateUtilsProtocol {
    func stringFromDate(date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, dateFormat: String?) -> String
    func weekendDateStrings(travelInterval: TravelInterval) -> (String, String)
    func formattedTravelInterval(travelInterval: TravelInterval) -> String
    func hoursDifference(date1: Date, date2: Date) -> Int
}

extension DateUtilsProtocol {
    func stringFromDate(date: Date, dateStyle: DateFormatter.Style = DateFormatter.Style.medium, timeStyle: DateFormatter.Style = DateFormatter.Style.none, dateFormat: String? = nil) -> String {
        return stringFromDate(date: date, dateStyle: dateStyle, timeStyle: timeStyle, dateFormat: dateFormat)
    }
}
