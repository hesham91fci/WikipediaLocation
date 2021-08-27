//
//  ArticleDetailsQuery.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/25/21.
//

import Foundation
struct ArticleDetailsPostQuery: ApiObject {
    private let action: String = "query"
    private let properties = "info|description|images"
    private let internalProperties = "url"
    let pageId: String

    func toDictionary() -> [String: Any] {
        ["pageids": pageId,
         "action": action,
         "inprop": internalProperties,
         "prop": properties,
         "format": "json"]
    }
}
