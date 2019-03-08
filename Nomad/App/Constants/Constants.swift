//
//  Constants.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import UIKit
import UIGradient

struct Constants {
    struct GeneralProperties {
        static let appName = "Nomad"
        static let fontName = "Futura"
        static let fontSize = CGFloat(16.0)
        static let dateFormat = "dd/MM/yyyy"
        static let cachingHours = 8
    }

    struct CoreData {
        static let modelName = "Nomad"
        static let FlightEntityName = "FlightEntity"
        static let FlightsFilterEntityName = "FlightsFilterEntity"
    }

    struct DefaultFilter {
        static let from = Location(id: "TXL", code: "TXL", name: "Berlin Tegel")
        static let travelInterval = TravelInterval.thisWeekend
        static let price = 100
        static let limit = 30
        static let partner = "skyscanner"
        static let nightsInDestinationFrom = 2
        static let nightsInDestinationTo = 2
        static let maxStopOvers = 0
        static let currency = "EUR"
    }

    struct NavigationBar {
        static let tintColorHex = "#fff"
    }
    
    struct ViewControllers {
        struct Flights {
            static let viewControllerTitle = "Flights"
            static let backgroundColor = GradientLayer.purpleLake
            static let activityIndicatorWidth = CGFloat(30.0)
            static let activityIndicatorHeight = CGFloat(30.0)
            static let activityIndicatorColorHex = "#fff"

            struct ErrorView {
                static let cornerRadius = CGFloat(8.0)
                static let leftConstraint = CGFloat(12.0)
                static let rightConstraint = CGFloat(12.0)
                static let bottomConstraint = CGFloat(82.0)
            }

            struct CollectionView {
                static let cellName = "FlightsCollectionViewCell"
                static let cellIdentifier = "FlightsCollectionViewCell"
                static let edgeInsets = UIEdgeInsets(top: CGFloat(0.0), left: CGFloat(12.0), bottom: CGFloat(0.0), right: CGFloat(12.0))
            }

            struct CollectionViewCell {
                static let shadowColorHex = "#B8B8B8"
                static let cornerRadius = CGFloat(11.0)
                static let borderWidth = CGFloat(1.0)
                static let gradientViewColors =  [UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
                static let cardShadowRadius = CGFloat(10.0)
                static let cardShadowOpacity: Float = 1.0
                static let cardShadowOffset = CGSize(width: 0.0, height: 0.5)
                static let cardShadowColorHex = "#ECECEC"
                static let cardShadowColorAlpha = CGFloat(0.3)
                static let bookingButtonCornerRadius = CGFloat(4.0)
            }
        }

        struct Filter {
            static let viewControllerTitle = "Filter"

            struct Sections {
                struct DepartureSection {
                    static let departureSectionTitle = "Departure"
                    static let placeholder = "Select Airport"
                }
                struct TravelIntervalSection {
                    static let travelIntervalSectionTitle = "Travel Interval"
                    static let title = "When?"
                    static let selectorTitle = "When?"
                }
                struct PriceSection {
                    static let priceSectionTitle = "Price"
                    static let sliderMinimumValue = Float(0.0)
                    static let sliderMaximumValue = Float(200.0)
                    static let sliderSteps = UInt((PriceSection.sliderMaximumValue - PriceSection.sliderMinimumValue) / 10.0)
                }
            }
        }

        struct Locations {
            static let locationsSearchTextFieldPlaceholder = "Search for an airport.."
            struct LocationsTableView {
                static let cellName = "LocationsTableViewCell"
                static let cellIdentifier = "LocationsTableViewCell"
            }
        }
    }

    struct DataSources {
        struct FlightsLocalDataSource {
            static let priceSortDescriptorKey = "price"
            static let predicateFormatWithFilterId = "filterId = %@"
        }
    }

    struct ErrorViews {
        struct EmptyResultsView {
            static let name = "EmptyResultsView"
            static let retryButtonCornerRadius = CGFloat(4.0)
        }
    }
}
