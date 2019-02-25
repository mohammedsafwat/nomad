//
//  FilterViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit
import Eureka

class FilterViewController: FormViewController {

    // MARK: - Properties

    @IBOutlet private weak var doneBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDoneBarButtonItem()
        setupViewControllerTitle()
        setupViewControllerSections()
    }
}

// MARK: - Private Methods

extension FilterViewController {
    private func setupDoneBarButtonItem() {
        doneBarButtonItem.addAction(target: self, action: #selector(didTapDoneBarButtonItem))
    }

    private func setupViewControllerTitle() {
        self.title = "Filter"
    }

    private func setupViewControllerSections() {
        form

        +++ Section(Constants.ViewControllers.Filter.Sections.DepartureSection.departureSectionTitle)
        <<< TextRow() { row in
            row.placeholder = Constants.ViewControllers.Filter.Sections.DepartureSection.placeholder
        }

        +++ Section(Constants.ViewControllers.Filter.Sections.TravelIntervalSection.travelIntervalSectionTitle)
        <<< ActionSheetRow<String>() {
            $0.title = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.title
            $0.selectorTitle = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.selectorTitle
            $0.options = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.options
            $0.value = Constants.ViewControllers.Filter.Sections.TravelIntervalSection.options[0]    // initially selected
        }
    }
}

// MARK: - Selector Methods

extension FilterViewController {
    @objc private func didTapDoneBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
}
