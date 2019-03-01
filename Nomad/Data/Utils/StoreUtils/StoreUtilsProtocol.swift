//
//  StoreUtilsProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 01.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

protocol StoreUtilsProtocol {
    func storeCurrency(currency: String)
    func loadCurrency() -> String
}
