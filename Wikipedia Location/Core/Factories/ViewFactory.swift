//
//  ViewFactory.swift
//  News
//
//  Created by Hesham Ali on 2/16/21.
//

import Foundation
import SwiftUI
import Combine

class ViewFactory {
    let viewModelFactory: ViewModelFactoryProtocol!
    init(viewModelFactory: ViewModelFactoryProtocol) {
        self.viewModelFactory = viewModelFactory
    }

    var nearbyArticlesView: NearbyArticlesView {
        NearbyArticlesView(articlesLocatorViewModel: viewModelFactory.articleLocatorViewModel)
    }

    var articleDetailsView: ArticleDetailsView {
        ArticleDetailsView(articleDetailsViewModel: viewModelFactory.articleDetailsViewModel)
    }

}
