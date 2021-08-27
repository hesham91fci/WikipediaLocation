//
//  ResponseMocks.swift
//  NewsTests
//
//  Created by Hesham Ali on 2/22/21.
//

import Foundation
import Alamofire

@testable import Wikipedia_Location

struct ResponseMocks {
    static var nearbyArticlesResponse: NearbyArticles? {
        guard let fileUrl: URL = Bundle(identifier: "com.MaasGlobal.Wikipedia-LocationTests")?.url(forResource: "NearbyPlaces", withExtension: "json") else {
            fatalError("Error finding json file")
        }
        do {
            let jsonData: Data = try Data(contentsOf: fileUrl)
            guard let nearbyArticles = try? JSONDecoder().decode(NearbyArticles.self, from: jsonData) else {
                fatalError("Error parsing json file")
            }
            return nearbyArticles
        } catch {
            fatalError("Error parsing json file")
        }
    }

    static var articleDetailsResponse: ArticleDetails? {
        guard let fileUrl: URL = Bundle(identifier: "com.MaasGlobal.Wikipedia-LocationTests")?.url(forResource: "ArticleDetails", withExtension: "json") else {
            fatalError("Error finding json file")
        }
        do {
            let jsonData: Data = try Data(contentsOf: fileUrl)
            guard let articleDetails = try? JSONDecoder().decode(ArticleDetails.self, from: jsonData) else {
                fatalError("Error parsing json file")
            }
            return articleDetails
        } catch {
            fatalError("Error parsing json file")
        }
    }

    static var articleImagesResponse: ArticleImageResponse {
        guard let fileUrl: URL = Bundle(identifier: "com.MaasGlobal.Wikipedia-LocationTests")?.url(forResource: "ImageDetailsResponse", withExtension: "json") else {
            fatalError("Error finding json file")
        }
        do {
            let jsonData: Data = try Data(contentsOf: fileUrl)
            guard let imageDetails = try? JSONDecoder().decode(ArticleImageResponse.self, from: jsonData) else {
                fatalError("Error parsing json file")
            }
            return imageDetails
        } catch {
            fatalError("Error parsing json file")
        }
    }
}
