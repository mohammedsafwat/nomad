//
//  LocationsViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit
import RxSwift

protocol LocationsViewControllerDelegate: class {
    func didSelectLocation(location: Location)
}

class LocationsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var locationsSearchTextField: UITextField!
    @IBOutlet private weak var locationsTableView: UITableView!

    weak var locationsViewControllerDelegate: LocationsViewControllerDelegate?
    private let schedulersFacade = SchedulersFacade()
    private let disposeBag = DisposeBag()
    private lazy var viewModel: LocationsViewModel = {
        let locationsDataSource = DataModule.shared.locationsRepository()
        return LocationsViewModel(locationsDataSource: locationsDataSource, schedulersFacade: schedulersFacade)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupLocationsSearchTextField()
        setupLocationsTableView()

        // Setup Data Binding
        viewModel.locationsSearchInput = locationsSearchTextField.rx.text.map { $0 }
        viewModel.locations
            .asDriver(onErrorJustReturn: [])
            .drive(locationsTableView.rx.items(cellIdentifier: Constants.ViewControllers.Locations.LocationsTableView.cellIdentifier, cellType: LocationsTableViewCell.self)) { _, location, cell in
                cell.configure(location: location)
            }.disposed(by: disposeBag)

        locationsTableView.rx.modelSelected(Location.self)
            .subscribe(onNext: { [weak self] location in
                self?.locationsViewControllerDelegate?.didSelectLocation(location: location)
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

extension LocationsViewController {
    private func setupLocationsSearchTextField() {
        locationsSearchTextField.placeholder = Constants.ViewControllers.Locations.locationsSearchTextFieldPlaceholder
        locationsSearchTextField.font = UIFont(name: Constants.GeneralProperties.fontName, size: Constants.GeneralProperties.fontSize) ?? UIFont.systemFont(ofSize: Constants.GeneralProperties.fontSize)
    }

    private func setupLocationsTableView() {
        locationsTableView.tableFooterView = UIView()
        locationsTableView.register(UINib(nibName: Constants.ViewControllers.Locations.LocationsTableView.cellName, bundle: .main), forCellReuseIdentifier: Constants.ViewControllers.Locations.LocationsTableView.cellIdentifier)
    }
}
