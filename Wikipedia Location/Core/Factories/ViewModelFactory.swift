//
//  ViewModelFactory.swift
//  News
//
//  Created by Hesham Ali on 2/17/21.
//

import Foundation
import Combine
protocol ViewModelFactoryProtocol {
    var repoFactory: RepoFactoryProtocol { get }
    var articleLocatorViewModel: ArticleLocatorViewModel { get }
    var articleDetailsViewModel: ArticleDetailsViewModel { get }
}

class ViewModelFactory: ViewModelFactoryProtocol {
    var repoFactory: RepoFactoryProtocol = RepoFactory()
    var articleLocatorViewModel: ArticleLocatorViewModel
    var articleDetailsViewModel: ArticleDetailsViewModel
    init() {
        articleLocatorViewModel = ArticleLocatorViewModel(repo: repoFactory.articleManagerRepo)
        articleDetailsViewModel = ArticleDetailsViewModel(repo: repoFactory.articleManagerRepo)
    }

}
