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

    @IBOutlet private weak var flightsCollectionView: UICollectionView!
    @IBOutlet private weak var filterBarButtonItem: UIBarButtonItem!

    private let schedulersFacade = SchedulersFacade()
    private let disposeBag = DisposeBag()

    private lazy var viewModel: FlightsViewModel = {
        let flightsDataSource = DataModule.shared.flightsRepository()

        return FlightsViewModel(flightsDataSource: flightsDataSource, schedulersFacade: schedulersFacade)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupViewControllerBackgroundColor()
        setupNavigationBarStyle()
        setupFlightsCollectionView()
        setupFilterBarButtonItem()

        viewModel.flights
            .asDriver(onErrorJustReturn: [])
            .drive(flightsCollectionView.rx.items(cellIdentifier: Constants.ViewControllers.Flights.CollectionView.cellIdentifier, cellType: FlightsCollectionViewCell.self)) { _, flight, cell in
                cell.configure(flight: flight)
            }.disposed(by: disposeBag)

        // Data Binding
        viewModel.flights.subscribe(onNext: { flights in
            print("We have some Flights: \(flights)")
        }, onError: { error in
            print("An Error Happend: \(error)")
        }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        viewModel.filter.accept(FlightsFilter(from: "TXL", dateFrom: "09/03/2019", returnFrom: "11/03/2019", price: 80, limit: 100))
    }
}

// MARK: - FlightsCollectionViewFlowLayout Delegate

extension FlightsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.ViewControllers.Flights.CollectionView.edgeInsets
    }
}

// MARK: - Private Methods

extension FlightsViewController {
    private func setupViewControllerBackgroundColor() {
        self.view.backgroundColor = UIColor.fromGradient(Constants.ViewControllers.Flights.backgroundColor, frame: self.view.frame)
    }

    private func setupNavigationBarStyle() {
        self.navigationController?.navigationBar.makeTransparent(withTintColor: UIColor(hexString: Constants.NavigationBar.tintColorHex))
    }
    
    private func setupFlightsCollectionView() {
        let cellNib = UINib(nibName: Constants.ViewControllers.Flights.CollectionView.cellName, bundle: .main)
        flightsCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.ViewControllers.Flights.CollectionView.cellIdentifier)
        flightsCollectionView.delegate = self
        flightsCollectionView.allowsSelection = false
    }

    private func setupFilterBarButtonItem() {
        filterBarButtonItem.addAction(target: self, action: #selector(didTapFilterBarButtonItem))
    }
}

// MARK: - Selector Methods

extension FlightsViewController {
    @objc private func didTapFilterBarButtonItem() {
        performSegue(withIdentifier: StoryboardSegue.flightsToFilters.rawValue, sender: nil)
    }
}

