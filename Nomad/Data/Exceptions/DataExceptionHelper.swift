//
//  DataExceptionHelper.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DataExceptionHelper {
    class func isSuccessful(_ statusCode: Int?) -> Bool {
        guard let statusCode = statusCode else { return false }
        return 200 ... 300 ~= statusCode
    }
}
