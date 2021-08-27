//
//  TestRepoFactory.swift
//  NewsTests
//
//  Created by Hazem Abdelfattah on 2/23/21.
//

import Foundation
@testable import Wikipedia_Location

class TestRepoFactory: RepoFactoryProtocol {
    var articleManagerRepo: ArticleManagerRepo {
        ArticleManagerRepo(networkHandler: NetworkDataHandlerStub())
    }
}
