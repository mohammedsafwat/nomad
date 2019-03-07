//
//  XCTest+StubbedData.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import XCTest

extension XCTest {
    func stubbedData(fromJSONFile jsonFileName: String) -> Data {
        let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json")
        let nsdata = NSData(contentsOfFile: path!)
        return Data(referencing: nsdata!)
    }
}
