//
//  RestNetworkClientProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift
import Alamofire

protocol RestNetworkClientProtocol {
    func performRequest(requestURLString: String, type: HTTPRequestType, parameters: [String: Any]) -> Observable<Result<(HTTPURLResponse, Any), DataError>>
}
