//
//  NearbyArticle.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import Foundation
import CoreLocation
// MARK: - NearbyArticles
struct NearbyArticles: Codable {
    let batchcomplete: String?
    let query: GeoSearchQuery?
}

// MARK: - Query
struct GeoSearchQuery: Codable {
    let geosearch: [Geosearch]?
}

// MARK: - Geosearch
struct Geosearch: Codable {
    let pageid, ns: Int?
    let title: String?
    let lat, lon, dist: Double?
    let primary: String?
}

struct ArticleLocation: Identifiable {
    let id: String = UUID().uuidString
    let coordinate: CLLocationCoordinate2D
}
