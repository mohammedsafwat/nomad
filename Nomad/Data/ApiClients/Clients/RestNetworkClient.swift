//
//  RestNetworkClient.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Alamofire
import RxSwift

class RestNetworkClient: RestNetworkClientProtocol {
    func performRequest(requestURLString: String, type: HTTPRequestType) -> Observable<[String: Any]> {
        return Observable<[String: Any]>.create { observer -> Disposable in
            do {
                guard let url = URL(string: requestURLString) else {
                    throw DataErrorHelper.requestFailedError
                }
                
                let request = try URLRequest(url: url, method: type == .get ? HTTPMethod.get : HTTPMethod.post)
                Alamofire.request(request).responseJSON { response in
                    guard response.result.isSuccess else {
                        observer.onError(DataErrorHelper.requestFailedError)
                        return
                    }
                    guard let jsonResponse = response.result.value as? [String: Any] else {
                        observer.onError(DataErrorHelper.requestFailedError)
                        return
                    }
                    observer.onNext(jsonResponse)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DataErrorHelper.requestFailedError)
            }
            return Disposables.create()
        }
    }
}
