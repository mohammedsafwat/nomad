//
//  Result.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
