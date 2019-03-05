//
//  FlightsViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView
import EasyPeasy

class FlightsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var flightsCollectionView: UICollectionView!
    @IBOutlet private weak var filterBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var departureCityLabel: UILabel!
    @IBOutlet private weak var travelIntervalLabel: UILabel!
    @IBOutlet private weak var travelIntervalDatesLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    private var emptyResultsView: EmptyResultsView?
    private var activityIndicatorView: NVActivityIndicatorView?

    private let schedulersFacade = SchedulersFacade()
    private let storeUtils = StoreUtils()
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
        setupActivityIndicatorView()
        setupErrorView()

        // Setup Data Binding
        viewModel.flightsFilter
            .observeOn(schedulersFacade.mainScheduler())
            .subscribe(onNext: { [unowned self] flightsFilter in
                self.updateHomeScreenLabels(flightsFilter: flightsFilter)
            }).disposed(by: disposeBag)

        viewModel.flightsResponse
            .observeOn(schedulersFacade.mainScheduler())
            .subscribe(onNext: { [unowned self] flightsResponse in
                guard let flights = flightsResponse.flights else { return }
                self.flightsCollectionView.isHidden = flights.isEmpty ? true : false
                self.emptyResultsView?.isHidden = flights.isEmpty ? false : true
            }).disposed(by: disposeBag)

        viewModel.flights
            .asDriver(onErrorJustReturn: [])
            .drive(flightsCollectionView.rx.items(cellIdentifier: Constants.ViewControllers.Flights.CollectionView.cellIdentifier, cellType: FlightsCollectionViewCell.self)) { _, flight, cell in
                cell.configure(flight: flight)
                cell.bookFlight = {
                    AppUtils.openUrl(urlString: flight.deepLink)
                }
            }.disposed(by: disposeBag)
        
        viewModel.requestStatus
            .observeOn(schedulersFacade.mainScheduler())
            .subscribe(onNext: { [unowned self] requestStatus in
                switch requestStatus.status {
                case .loading:
                    self.activityIndicatorView?.startAnimating()
                case .success, .failed:
                    self.activityIndicatorView?.stopAnimating()
                }
                
                if let error = requestStatus.error {
                    NotificationBannerUtils.showNotifiationBanner(layout: .cardView, theme: .info, iconStyle: .none, title: Constants.GeneralProperties.appName, content: error.dataErrorMessage ?? error.localizedDescription)
                }
            }).disposed(by: disposeBag)
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

// MARK: - FilterViewController Delegate

extension FlightsViewController: FilterViewControllerDelegate {
    func didUpdateFlightsFilter(flightsFilter: FlightsFilter?) {
        viewModel.setFlightsFilter(filter: flightsFilter)
    }
}

// MARK: - Segues

extension FlightsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch storyboardSegue(for: segue) {
        case .flightsToFilter:
            guard let filterNavigationController = segue.destination as? UINavigationController,
                let filterViewController = filterNavigationController.topViewController as? FilterViewController else { return }
            filterViewController.inject(FlightsFilter(from: viewModel.flightsFilter.value.from, travelInterval: viewModel.flightsFilter.value.travelInterval, price: viewModel.flightsFilter.value.price, limit: viewModel.flightsFilter.value.limit, maxStopovers: viewModel.flightsFilter.value.maxStopovers))
            filterViewController.filterViewControllerDelegate = self
        default:
            break
        }
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

    private func updateHomeScreenLabels(flightsFilter: FlightsFilter) {
        departureCityLabel.text = flightsFilter.from.name
        travelIntervalLabel.text = flightsFilter.travelInterval.rawValue
        travelIntervalDatesLabel.text = DateUtils.formattedTravelInterval(travelInterval: flightsFilter.travelInterval)
        priceLabel.text = AppUtils.formatPrice(price: flightsFilter.price)
    }

    private func setupFilterBarButtonItem() {
        filterBarButtonItem.addAction(target: self, action: #selector(didTapFilterBarButtonItem))
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: Constants.ViewControllers.Flights.activityIndicatorWidth, height: Constants.ViewControllers.Flights.activityIndicatorHeight)), type: .ballSpinFadeLoader, color: UIColor(hexString: Constants.ViewControllers.Flights.activityIndicatorColorHex))
        activityIndicatorView?.center.x = self.view.center.x
        activityIndicatorView?.center.y = flightsCollectionView.frame.origin.y - Constants.ViewControllers.Flights.activityIndicatorHeight
        guard let activityIndicatorView = activityIndicatorView else { return }
        self.view.addSubview(activityIndicatorView)
    }

    private func setupErrorView() {
        guard let errorView = Bundle.main.loadNibNamed(Constants.ErrorViews.EmptyResultsView.name, owner: nil, options: nil)?.first as? EmptyResultsView else { return }
        self.view.addSubview(errorView)
        emptyResultsView = errorView
        errorView.setRoundedCorners(cornerRadius: Constants.ViewControllers.Flights.ErrorView.cornerRadius)
        errorView.isHidden = true
        errorView.easy.layout([
            Height(flightsCollectionView.frame.size.height * 0.5),
            Left(Constants.ViewControllers.Flights.ErrorView.leftConstraint),
            Right(Constants.ViewControllers.Flights.ErrorView.rightConstraint),
            Bottom(Constants.ViewControllers.Flights.ErrorView.bottomConstraint)
        ])
        errorView.retryButtonAction = {
            self.viewModel.tryAgain()
        }
    }
}

// MARK: - Selector Methods

extension FlightsViewController {
    @objc private func didTapFilterBarButtonItem() {
        performSegue(withIdentifier: StoryboardSegue.flightsToFilter.rawValue, sender: nil)
    }
}
