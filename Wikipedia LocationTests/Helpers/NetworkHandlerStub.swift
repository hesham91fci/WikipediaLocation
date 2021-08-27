//
//  NetworkHandlerStub.swift
//  NewsTests
//
//  Created by Hesham Ali on 2/22/21.
//

import Foundation
import Combine
import Alamofire

@testable import Wikipedia_Location
// swiftlint:disable force_cast

class NetworkDataHandlerStub: NetworkHandler {

    override public func performRequest<T: Codable>(url: String, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding) -> AnyPublisher<T, AppError> {
        guard let params = params, let response = parseRequest(parameters: params) else {
            return Fail(error: AppError(message: .invalidUrl, errorCode: 400))
                .eraseToAnyPublisher()
        }
        return Just(response as! T).mapError({ _ -> AppError in
            TestMocks.getAppError()
        })
        .eraseToAnyPublisher()
    }

    func parseRequest(parameters: Parameters) -> Codable? {
        if let list = parameters["list"] as? String, list.contains("geosearch") {
            return ResponseMocks.nearbyArticlesResponse
        } else if let properties = parameters["prop"] as? String, properties.contains("info|description|images") {
            return ResponseMocks.articleDetailsResponse
        } else if let _ = parameters["iiprop"] {
            return ResponseMocks.articleImagesResponse
        } else {
            return nil
        }
    }
}
