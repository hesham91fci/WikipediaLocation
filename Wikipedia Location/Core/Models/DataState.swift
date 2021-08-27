//
//  DataState.swift
//  News
//
//  Created by Hesham Ali on 8/7/21.
//

import Foundation
public enum DataState: Equatable {
    case loading
    case finished
    case success(message: String)
    case none
    case error(err: AppError)

    public static func == (lhs: DataState, rhs: DataState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.finished, .finished),
             (.none, .none):
            return true
        case (.error(let err1), .error(let err2)):
            return err1.message == err2.message
        default:
            return false
        }
    }

}
