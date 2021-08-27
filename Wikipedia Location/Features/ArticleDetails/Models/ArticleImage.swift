//
//  ArticleImage.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/26/21.
//

import Foundation

// MARK: - ArticleImage
struct ArticleImageResponse: Codable {
    let batchcomplete: String?
    let query: ArticleImageResponseQuery?
}

// MARK: - Query
struct ArticleImageResponseQuery: Codable {
    let pages: ArticleImagePages?
}

// MARK: - Pages
struct ArticleImagePages: Codable {
    let articleImagePages: [String: ArticleImagePageId]?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        articleImagePages = try container.decode([String: ArticleImagePageId].self)
    }
}

// MARK: - The1
struct ArticleImagePageId: Codable {
    let ns: Int?
    let title, missing, known, imagerepository: String?
    let imageinfo: [Imageinfo]?
}

// MARK: - Imageinfo
struct Imageinfo: Codable {
    let url, descriptionurl: String?
    let descriptionshorturl: String?
}
