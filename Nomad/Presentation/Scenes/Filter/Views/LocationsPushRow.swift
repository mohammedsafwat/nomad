//
//  LocationsPushRow.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Eureka

public final class LocationsPushRow<T: Equatable>: SelectorRow<PushSelectorCell<T>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .segueName(segueName: StoryboardSegue.filterToLocations.rawValue, onDismiss: nil)
    }
}
