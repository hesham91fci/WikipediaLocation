//
//  ApiObject.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import Foundation
protocol ApiObject {
    func toDictionary() -> [String: Any]
}
