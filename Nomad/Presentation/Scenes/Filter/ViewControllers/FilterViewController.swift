//
//  FilterViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit
import Eureka
import RxSwift
import RxCocoa

protocol FilterViewControllerDelegate: class {
    func didUpdateFlightsFilter(flightsFilter: FlightsFilter?)
}

class FilterViewController: FormViewController {

    // MARK: - Properties

    @IBOutlet private weak var doneBarButtonItem: UIBarButtonItem!

    weak var filterViewControllerDelegate: FilterViewControllerDelegate?
    private let disposeBag = DisposeBag()

    private(set) lazy var viewModel: FilterViewModel = {
        let storeUtils = StoreUtilsModule.shared.storeUtils
        return FilterViewModel(storeUtils: storeUtils)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupDoneBarButtonItem()
        setupViewControllerTitle()
        setupViewControllerSections()

        // Setup Data Binding
        viewModel.flightsFilter.subscribe(onNext: { [weak self] flightsFilter in
            self?.updateDepartureRowTitle(title: flightsFilter?.from.name)
            self?.updateTravelIntervalTitle(title: flightsFilter?.travelInterval.rawValue)
            self?.updatePriceSliderValue(price: flightsFilter?.price)
        }).disposed(by: disposeBag)
    }
}

// MARK: - Segues

extension FilterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch storyboardSegue(for: segue) {
        case .filterToLocations:
            guard let locationsViewController = segue.destination as? LocationsViewController else { return }
            locationsViewController.locationsViewControllerDelegate = self
        default:
            break
        }
    }
}

// MARK: - LocationsViewController Delegate

extension FilterViewController: LocationsViewControllerDelegate {
    func didSelectLocation(location: Location) {
        updateDepartureRowTitle(title: location.name)
        viewModel.flightsFilter.value?.from = location
    }
}

// MARK: - Private Methods

extension FilterViewController {
    private func setupDoneBarButtonItem() {
        doneBarButtonItem.addAction(target: self, action: #selector(didTapDoneBarButtonItem))
    }

    private func setupViewControllerTitle() {
        self.title = Constants.ViewControllers.Filter.viewControllerTitle
    }

    private func setupViewControllerSections() {
        form

        +++ Section(Constants.ViewControllers.Filter.Sections.DepartureSection.departureSectionTitle)
        <<< LocationsPushRow<String>() {
            $0.title = Constants.ViewControllers.Filter.Sections.DepartureSection.placeholder
        }.cellSetup { cell, row in
            cell.textLabel?.font = UIFont(name: Constants.GeneralProperties.fontName, size: Constants.GeneralProperties.fontSize) ?? UIFont.systemFont(ofSize: Constants.GeneralProperties.fontSize)
        }

        +++ Section(Constants.ViewControllers.Filter.Sections.TravelIntervalSection.travelIntervalSectionTitle)
        <<< ActionSheetRow<String>() {
            $0.title = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.title
            $0.selectorTitle = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.selectorTitle
            $0.options = TravelInterval.allCases.compactMap { $0.rawValue }
            $0.value = $0.options?[0]
        }.cellSetup { cell, row in
            cell.textLabel?.font = UIFont(name: Constants.GeneralProperties.fontName, size: Constants.GeneralProperties.fontSize) ?? UIFont.systemFont(ofSize: Constants.GeneralProperties.fontSize)
        }.cellUpdate { [weak self] cell, row in
            guard let travelInterval = TravelInterval(rawValue: row.value ?? "") else { return }
            self?.viewModel.flightsFilter.value?.travelInterval = travelInterval
        }

        +++ Section(viewModel.priceSectionTitle)
        <<< SliderRow() {
            $0.shouldHideValue = false
            $0.steps = Constants.ViewControllers.Filter.Sections.PriceSection.sliderSteps
        }.cellSetup { cell, row in
            cell.slider.minimumValue = Constants.ViewControllers.Filter.Sections.PriceSection.sliderMinimumValue
            cell.slider.maximumValue = Constants.ViewControllers.Filter.Sections.PriceSection.sliderMaximumValue
            cell.valueLabel.font = UIFont(name: Constants.GeneralProperties.fontName, size: Constants.GeneralProperties.fontSize) ?? UIFont.systemFont(ofSize: Constants.GeneralProperties.fontSize)
        }.cellUpdate { [weak self] cell, row in
            self?.viewModel.flightsFilter.value?.price = Int(row.value ?? Float(Constants.DefaultFilter.price))
        }
    }

    private func updateDepartureRowTitle(title: String?) {
        guard let locationsPushRow = self.form.allRows.first as? LocationsPushRow<String> else { return }
        locationsPushRow.title = title
    }

    private func updateTravelIntervalTitle(title: String?) {
        guard let travelIntervalRow = self.form.allRows[1] as? ActionSheetRow<String> else { return }
        travelIntervalRow.value = title
    }

    private func updatePriceSliderValue(price: Int?) {
        guard let priceSliderRow = self.form.allRows[2] as? SliderRow, let price = price else { return }
        priceSliderRow.value = Float(price)
    }
}

// MARK: - Selector Methods

extension FilterViewController {
    @objc private func didTapDoneBarButtonItem() {
        filterViewControllerDelegate?.didUpdateFlightsFilter(flightsFilter: viewModel.flightsFilter.value)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Injectable Protocol

extension FilterViewController: Injectable {
    typealias T = FlightsFilter

    func inject(_ flightsFilter: T?) {
        viewModel.flightsFilter.accept(flightsFilter)
    }

    func assertDependencies() {
        assert(viewModel.flightsFilter.value != nil, "`inject` method on FilterViewController should be called")
    }
}
