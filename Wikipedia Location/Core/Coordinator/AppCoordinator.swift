//
//  AppCoordinator.swift
//  News
//
//  Created by Hesham Ali on 2/10/21.
//

import Foundation
import SwiftUI
import Combine
import UIKit
class AppCoordinator: CoordinatorProtocol {
    let viewFactory: ViewFactory!
    let locationManager: LocationManagerPublisher
    let window: UIWindow?
    var subscriptions: [AnyCancellable] = []

    init(window: UIWindow? = nil, viewFactory: ViewFactory, locationManager: LocationManagerPublisher) {
        self.viewFactory = viewFactory
        self.window = window
        self.locationManager = locationManager
    }

    var navigationController: UINavigationController! {
        window?.rootViewController as? UINavigationController
    }

    func start() {
        let nearbyArticlesView: NearbyArticlesView = viewFactory.nearbyArticlesView
        let articleLocatorViewModel: ArticleLocatorViewModel = nearbyArticlesView.articlesLocatorViewModel
        articleLocatorViewModel.inputs.nearbyArticlesRequested.sink { [weak self] _ in
            self?.locationManager.inputs.locationRequested.send()
        }.store(in: &subscriptions)
        self.locationManager.outputs.locationsSubject.sink { (locations) in
            articleLocatorViewModel.inputs.locationRetrieved.send(locations[0])
        }.store(in: &subscriptions)
        showSelectedArticleView(articleLocatorViewModel: articleLocatorViewModel)
        attachRootView(nearbyArticlesView)
    }

    private func showSelectedArticleView(articleLocatorViewModel: ArticleLocatorViewModel) {
        let articleDetailsViewModel: ArticleDetailsViewModel = self.viewFactory.viewModelFactory.articleDetailsViewModel
        articleLocatorViewModel.outputs.$selectedArticle.sink { [weak self] (selectedArticle) in
            guard let self = self else {
                return
            }
            guard let selectedArticle = selectedArticle else {
                return
            }
            articleDetailsViewModel.inputs.selectedArticleSubject.send(selectedArticle)
            articleLocatorViewModel.outputs.shownView = self.viewFactory.articleDetailsView.toAnyView()
        }.store(in: &subscriptions)

    }

    private func attachRootView<T: View>(_ view: T) {
        if let window = window {
            let controller = UIHostingController(rootView: view)
            let nav = UINavigationController(rootViewController: controller)
            nav.navigationBar.isHidden = true
            window.rootViewController = nav
        }

    }

    private func pushView<T: View>(_ view: T) {
        if window != nil {
            let controller = UIHostingController(rootView: view)
            self.navigationController.navigationBar.isHidden = false
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
