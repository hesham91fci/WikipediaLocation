//
//  ViewModelFactory.swift
//  News
//
//  Created by Hesham Ali on 2/17/21.
//

import Foundation
@testable import Wikipedia_Location

class TestingViewModelFactory: ViewModelFactoryProtocol {
    var articleLocatorViewModel: ArticleLocatorViewModel
    var articleDetailsViewModel: ArticleDetailsViewModel
    var repoFactory: RepoFactoryProtocol = TestRepoFactory()
    init() {
        articleLocatorViewModel = ArticleLocatorViewModel(repo: repoFactory.articleManagerRepo)
        articleDetailsViewModel = ArticleDetailsViewModel(repo: repoFactory.articleManagerRepo)
    }
}
