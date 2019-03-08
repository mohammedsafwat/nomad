//
//  FlightsCollectionViewCell.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

class FlightsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    @IBOutlet private weak var outboundDepartureTimeLabel: UILabel!
    @IBOutlet private weak var outboundDateLabel: UILabel!
    @IBOutlet private weak var outboundArrivalTimeLabel: UILabel!
    @IBOutlet private weak var outboundDepartureCityLabel: UILabel!
    @IBOutlet private weak var outboundArrivalCityLabel: UILabel!
    @IBOutlet private weak var returnDepartureTimeLabel: UILabel!
    @IBOutlet private weak var returnDateLabel: UILabel!
    @IBOutlet private weak var returnArrivalTimeLabel: UILabel!
    @IBOutlet private weak var returnDepartureCityLabel: UILabel!
    @IBOutlet private weak var returnArrivalCityLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var bookingButton: UIButton!

    // MARK: - Action Callbacks

    var bookFlight: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupContentViewCornerRadius()
        setupCellShadow()
        setupBookingButtonCornerRadius()
        setupBookingButtonAction()
    }

    // MARK: - Configure Method

    func configure(flight: Flight) {
        guard let route = flight.route, route.count > 1 else { return }
        let outboundFlight = route[0]
        let returnFlight = route[1]

        outboundDepartureTimeLabel.text = outboundFlight.departureTimeFormatted
        outboundDateLabel.text = outboundFlight.departureDateFormatted
        outboundArrivalTimeLabel.text = outboundFlight.arrivalTimeFormatted
        outboundDepartureCityLabel.text = outboundFlight.cityFrom
        outboundArrivalCityLabel.text = outboundFlight.cityTo

        returnDepartureTimeLabel.text = returnFlight.departureTimeFormatted
        returnDateLabel.text = returnFlight.departureDateFormatted
        returnArrivalTimeLabel.text = returnFlight.arrivalTimeFormatted
        returnDepartureCityLabel.text = returnFlight.cityFrom
        returnArrivalCityLabel.text = returnFlight.cityTo

        priceLabel.text = AppUtils.formatPrice(price: flight.price)
    }
}

// MARK: - Private Methods

extension FlightsCollectionViewCell {
    private func setupContentViewCornerRadius() {
        self.layer.cornerRadius = Constants.ViewControllers.Flights.CollectionViewCell.cornerRadius
    }

    private func setupCellShadow() {
        let radius = Constants.ViewControllers.Flights.CollectionViewCell.cardShadowRadius
        let opacity = Constants.ViewControllers.Flights.CollectionViewCell.cardShadowOpacity
        let offset = Constants.ViewControllers.Flights.CollectionViewCell.cardShadowOffset
        let shadowColor = UIColor(hexString: Constants.ViewControllers.Flights.CollectionViewCell.cardShadowColorHex)
            .withAlphaComponent(Constants.ViewControllers.Flights.CollectionViewCell.cardShadowColorAlpha)
        let shadow = Shadow(radius: radius, opacity: opacity, offset: offset, masksToBounds: false, shadowColor: shadowColor)
        contentView.addShadow(shadow: shadow)
    }

    private func setupBookingButtonAction() {
        bookingButton.addTarget(self, action: #selector(didTapBookButton), for: .touchUpInside)
    }

    private func setupBookingButtonCornerRadius() {
        bookingButton.layer.cornerRadius = Constants.ViewControllers.Flights.CollectionViewCell.bookingButtonCornerRadius
    }
}

// MARK: - Selector Methods

extension FlightsCollectionViewCell {
    @objc private func didTapBookButton() {
        bookFlight?()
    }
}
