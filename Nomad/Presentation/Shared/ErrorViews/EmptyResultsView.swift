//
//  EmptyResultsView.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

class EmptyResultsView: UIView {

    // MARK: - Properties

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!

    // MARK: - Callbacks

    var retryButtonAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupRetryButton()
    }
}

// MARK: - Private Methods

extension EmptyResultsView {
    private func setupRetryButton() {
        retryButton.setRoundedCorners(cornerRadius: Constants.ErrorViews.EmptyResultsView.retryButtonCornerRadius)
        retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
    }
}

// MARK: - Selector Methods

extension EmptyResultsView {
    @objc private func didTapRetryButton() {
        retryButtonAction?()
    }
}
