//
//  Location.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import ObjectMapper

class Location: Mappable {

    // MARK: - Properties

    var id: String?
    var code: String?
    var name: String?

    // MARK: - Initializer

    init(id: String?, code: String?, name: String?) {
        self.id = id
        self.code = code
        self.name = name
    }

    // MARK: - Object Mapping

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        id <- map[API.Locations.ResponseKeys.id]
        code <- map[API.Locations.ResponseKeys.code]
        name <- map[API.Locations.ResponseKeys.name]
    }
}

// MARK: - Equatable Protocol

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id &&
            lhs.code == rhs.code &&
            lhs.name == rhs.name
    }
}

// MARK: - Hashable Protocol

extension Location: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(code)
        hasher.combine(name)
    }
}

