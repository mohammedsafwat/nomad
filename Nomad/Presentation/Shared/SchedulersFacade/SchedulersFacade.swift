//
//  SchedulersFacade.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

class SchedulersFacade: SchedulersFacadeProtocol {
    // Background thread scheduler
    func backgroundScheduler() -> SchedulerType {
        return ConcurrentDispatchQueueScheduler(qos: .background)
    }

    // Main thread scheduler
    func mainScheduler() -> SchedulerType {
        return MainScheduler.instance
    }
}
