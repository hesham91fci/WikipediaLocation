//
//  NetworkHandler.swift
//  News
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
import Alamofire

public class NetworkHandler {
    private var environment: Environment = .development
    public func performRequest<T: Codable>(url: String, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding) -> AnyPublisher<T, AppError> {

        guard let url = URL(string: environment.rawValue + url) else {
            return Fail(error: AppError(message: .invalidUrl, errorCode: nil)).eraseToAnyPublisher()
        }

        return AF.request(url,
            method: method,
            parameters: params,
            encoding: encoding) { $0.timeoutInterval = 30 }
            .validate()
            .publishDecodable(type: T.self, emptyResponseCodes: [200, 204, 205])
            .value()
            .mapError { (error) -> AppError in
                print("NetworkHandler:: \(error)")
                return AppError(message: error.localizedDescription, errorCode: error.responseCode)
            }
            .eraseToAnyPublisher()

    }

}
