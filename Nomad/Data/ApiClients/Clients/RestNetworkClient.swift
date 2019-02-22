//
//  RestNetworkClient.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

class RestNetworkClient: RestNetworkClientProtocol {

    // MARK: - Properties

    private var headers: [String: String]
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(headers: [String: String]) {
        self.headers = headers
    }

    // MARK: - Request Methods

    func performRequest(requestURLString: String, type: HTTPRequestType, parameters: [String: Any]) -> Observable<Result<(HTTPURLResponse, Any), DataError>> {
        return Observable<Result<(HTTPURLResponse, Any), DataError>>.create { observer -> Disposable in
            if let url = URL(string: requestURLString) {
                RxAlamofire.requestJSON(type == .get ? .get : .post, url, parameters: parameters, headers: self.headers)
                    .subscribe(onNext: { result in
                        observer.onNext(.success(result))
                        observer.onCompleted()
                    }, onError: { error in
                        observer.onError(error)
                    }).disposed(by: self.disposeBag)
            } else {
                observer.onError(DataErrorHelper.requestFailedError)
            }
            return Disposables.create()
        }
    }
}
