//
//  FilterViewController.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var doneBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDoneBarButtonItem()
    }
}

// MARK: - Private Methods

extension FilterViewController {
    private func setupDoneBarButtonItem() {
        doneBarButtonItem.addAction(target: self, action: #selector(didTapDoneBarButtonItem))
    }
}

// MARK: - Selector Methods

extension FilterViewController {
    @objc private func didTapDoneBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
}
