//
//  SchedulersFacadeProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

protocol SchedulersFacadeProtocol {
    func backgroundScheduler() -> SchedulerType
    func mainScheduler() -> SchedulerType
}
