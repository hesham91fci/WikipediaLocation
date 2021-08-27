//
//  ArticleLocatorRepo.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import Foundation
import Combine
import Alamofire
class ArticleManagerRepo: BaseRepo {
    func loadNearbyArticles(nearbyArticlesQuery: NearbyArticlesQuery) -> AnyPublisher<NearbyArticles, AppError> {
        networkHandler.performRequest(url: Constants.APIs.baseAPI, method: .get, params: nearbyArticlesQuery.toDictionary(), encoding: URLEncoding.queryString)
    }

    func loadArticleDetails(articleDetailsPostQuery: ArticleDetailsPostQuery) -> AnyPublisher<ArticleDetails, AppError> {
        networkHandler.performRequest(url: Constants.APIs.baseAPI, method: .get, params: articleDetailsPostQuery.toDictionary(), encoding: URLEncoding.queryString)
    }

    func loadArticleImage(imageFetchQuery: ImageFetchQuery) -> AnyPublisher<ArticleImageResponse, AppError> {
        networkHandler.performRequest(url: Constants.APIs.baseAPI, method: .get, params: imageFetchQuery.toDictionary(), encoding: URLEncoding.queryString)
    }
}
