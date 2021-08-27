//
//  ArticleDetailsViewModel.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/24/21.
//
import Foundation

// MARK: - ArticleDetails
struct ArticleDetails: Codable {
    let batchcomplete: String?
    let query: ArticleDetailsQuery?

    enum CodingKeys: String, CodingKey {
        case batchcomplete
        case query
    }
}

// MARK: - Query
struct ArticleDetailsQuery: Codable {
    let pages: Pages?
}

// MARK: - Pages
struct Pages: Codable {
    var pageId: [String: PageId]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        pageId = try container.decode([String: PageId].self)
    }
}

// MARK: - The18806750
struct PageId: Codable {
    let pageid, ns: Int?
    let title, contentmodel, pagelanguage, pagelanguagehtmlcode: String?
    let pagelanguagedir: String?
    let touched: String?
    let lastrevid, length: Int?
    let fullurl: String?
    let editurl: String?
    let canonicalurl: String?
    let articleDescription, descriptionsource: String?
    let images: [ArticleImage]?

    enum CodingKeys: String, CodingKey {
        case pageid, ns, title, contentmodel, pagelanguage, pagelanguagehtmlcode, pagelanguagedir, touched, lastrevid, length, fullurl, editurl, canonicalurl
        case articleDescription = "description"
        case descriptionsource, images
    }
}

// MARK: - Image
struct ArticleImage: Codable {
    let ns: Int?
    let title: String?
}
