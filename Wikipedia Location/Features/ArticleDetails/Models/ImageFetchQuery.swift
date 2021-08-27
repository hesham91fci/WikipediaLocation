//
//  ImageFetchQuery.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/26/21.
//

import Foundation
struct ImageFetchQuery: ApiObject {
    let action="query"
    let title: String
    let prop="imageinfo"
    let iiprop="url"
    func toDictionary() -> [String: Any] {
        ["action": action,
         "titles": title,
         "prop": prop,
         "iiprop": iiprop,
         "format": "json"]
    }
}
