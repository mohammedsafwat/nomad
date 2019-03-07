//
//  MockDataModule.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxTest
@testable import Nomad

class MockDataModule {

    // MARK: - Properties

    static let shared = MockDataModule()

    private init() {}

    var mockFlightsNonEmptyResponse: FlightsResponse {
        return FlightsResponse(flights: [Flight(route: [RouteItem(flyTo: "TXL", flyFrom: "DUS", cityTo: "Berlin", cityFrom: "Düsseldorf", departureTime: 1552119000, arrivalTime: 1552123200, flightNumber: 9049, airline: "EW"), RouteItem(flyTo: "DUS", flyFrom: "TXL", cityTo: "Düsseldorf", cityFrom: "Berlin", departureTime: 1552338900, arrivalTime: 1552343400, flightNumber: 8049, airline: "EW")], price: 110, deepLink: "https://www.kiwi.com/deep?from=TXL&to=DUS&departure=09-03-2019&return=11-03-2019&flightsId=7879100739067794_0%7C7879100739067794_1&price=110&passengers=1&affilid=skyscanner_en&lang=en&currency=EUR&booking_token=zOigvDn0poq7PP6h4jLUORQvLR6lQx6fpbns3QAvN1mLd2gsW7V4z98twlI5CHjrUwRyR6+yRl/b+ctnm/I+ausMuAPai2wIRbnbsy+g/6NCuUeuGDlOxrxgTRAfJglTkQGa39hwscGRDCRtw/9vtHW6mKaTssWwhg8sncQ9lGJ+V6mGCUjzHlHpkwW298yniTy6PBZHQi4vh28K9Oog+ruwS7NfMIfdlhwSjtSmXJTUxlMDDqe+9KJamYODEAbEBcyW2pPDfV0IOeXPWURjgwR/Ol2E/rrBv6wMHbaMecxk/3F5eY8gfthFPjcVQ0XEjxfbJMxUld4TWQ2xDhkT3X/ey144wnK6tt+nH64b1vjjHC5E/JF0xLNLfzfJ7dYS01WKSEvlkFkmTSxtLKk0DkYKyJgT6f/Hp1YZk0M0aEtS1hqom34+Ig5tuExmzXOTDHE54SFCirkPAHtgXkJ94hVhKsjociMK4ZNjDAOObCgpjjIrAieyJ02ZSaKSdj6rbddW3RTuUZc7zgS/Ie/ucnlcTd2MZX91TDdgD4IDK4DupwNGbZZ5C/y7cL2Gs3T/7T3asktvAh0u3fvu0/ylPkQKJTS3frnbRpYwaloOLla69CFb9zhgWFHwtXCYXxq+yeUKrbo+/A1AjbynvFGvsrFkn7ewg/BPkvTORUnyKJBmcy0LDNR1TgTFScw0AueSF6YSJoNaxkAx9f0LSQhRTM3NU7MyeEea4orzBgYpgpTZVYR5kqSNhbkafMz6dGUCHvuBF+ae9H0TaF1kz6x1IIZqDHRY3gkA6TZwLXnNGY59jLnWqJBBslUR50+2a8tPF0VBEf1gCqPJjVBQsePLqFBt3lUNYF+6z5NZE1pzbzqVoePXXE8CFEmlwDzAPZe0")], currency: "EUR")
    }

    var mockFlightsEmptyResponse: FlightsResponse {
        return FlightsResponse(flights: [], currency: "EUR")
    }

    var mockFlightsFilter: FlightsFilter {
        return FlightsFilter(from: Constants.DefaultFilter.from, travelInterval: Constants.DefaultFilter.travelInterval, price: Constants.DefaultFilter.price, limit: Constants.DefaultFilter.limit, maxStopovers: Constants.DefaultFilter.maxStopOvers)
    }
}
