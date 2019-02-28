//
//  Injectable.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

protocol Injectable {
    associatedtype T
    func inject(_: T?)
    func assertDependencies()
}
