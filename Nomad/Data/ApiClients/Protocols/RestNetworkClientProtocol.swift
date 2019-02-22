//
//  RestNetworkClientProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

protocol RestNetworkClientProtocol {
    func performRequest(requestURLString: String, type: HTTPRequestType) -> Observable<[String: Any]>
}
