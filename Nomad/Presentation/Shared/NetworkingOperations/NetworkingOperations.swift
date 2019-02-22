//
//  NetworkingOperations.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

protocol NetworkingOperations {
    func refresh()
    func loadMore(itemsCount: Int)
    func tryAgain()
}
