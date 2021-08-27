//
//  NearbyArticlesQuery.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import Foundation
struct NearbyArticlesQuery: ApiObject {
    private let action: String = "query"
    private let list: String = "geosearch"
    let gsradius: Int
    let gscoord: String
    private let gsLimit: Int = 50

    func toDictionary() -> [String: Any] {
        ["action": action, "list": list, "gsradius": gsradius, "gscoord": gscoord, "gsLimit": gsLimit, "format": "json"]
    }
}
