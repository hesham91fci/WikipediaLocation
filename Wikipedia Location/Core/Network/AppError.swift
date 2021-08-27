//
//  AppError.swift
//  News
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation

public struct AppError: Error, Codable {
    let message: String?
    let errorCode: Int?
    init(message appMessage: ApiErrorMessages, errorCode: Int?) {
        self.message = appMessage.rawValue
        self.errorCode = errorCode
    }
    init(message: String, errorCode: Int?) {
        self.message = message
        self.errorCode = errorCode
    }
}

enum ApiErrorMessages: String {
    // MARK: - Network Messages
    case noInternetConnection = "It looks like your internet connection is off. Please turn it on and try again"
    case requestTimeout = "Request Timeout. Please check your network connection and try again"
    case defaultApiFaliureMessage = "An error occurred while retrieving data"
    case invalidUrl = "Invalid URL"
}
