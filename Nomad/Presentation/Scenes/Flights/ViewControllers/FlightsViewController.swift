//
//  FlightsViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit
import RxSwift

class FlightsViewController: UIViewController {

    // MARK: - Properties

    private let schedulersFacade = SchedulersFacade()
    private let disposeBag = DisposeBag()

    private lazy var viewModel: FlightsViewModel = {
        let flightsDataSource = DataModule.shared.flightsRepository()

        return FlightsViewModel(flightsDataSource: flightsDataSource, schedulersFacade: schedulersFacade)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupNavigationBarStyle()

        // Data Binding
        viewModel.flights.subscribe(onNext: { flights in
            print("We have some Flights: \(flights)")
        }, onError: { error in
            print("An Error Happend: \(error)")
        }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        viewModel.filter.accept(FlightsFilter(from: "TXL", dateFrom: "09/03/2019", dateTo: "10/03/2019", price: 50, limit: 5))
    }
}

// MARK: - Private Methods

extension FlightsViewController {
    func setupNavigationBarStyle() {
        self.navigationController?.navigationBar.makeTransparent(withTintColor: UIColor(hexString: Constants.NavigationBar.tintColorHex))
    }
}
