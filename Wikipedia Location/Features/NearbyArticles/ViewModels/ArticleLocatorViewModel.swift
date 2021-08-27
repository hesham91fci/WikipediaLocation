//
//  ArticleLocatorViewModel.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import Foundation
import Combine
import CoreLocation
import MapKit
import SwiftUI
final class ArticleLocatorInputs {
    let locationRetrieved: PassthroughSubject<CLLocation, Never> = PassthroughSubject()
    let nearbyArticlesRequested: PassthroughSubject<Void, Never> = PassthroughSubject()
    let selectedArticleLocationSubject: PassthroughSubject<ArticleLocation, Never> = PassthroughSubject()
}

final class ArticleLocatorOutputs: ObservableObject {
    @Published var articles: [Geosearch] = []
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var articleLocations: [ArticleLocation] = []
    @Published var selectedArticle: Geosearch?
    @Published var shownView: AnyView = EmptyView().toAnyView()
}

class ArticleLocatorViewModel: BaseViewModel<ArticleLocatorInputs, ArticleLocatorOutputs> {
    private let repo: ArticleManagerRepo!
    init(repo: ArticleManagerRepo) {
        self.repo = repo
        let articleLocatorInputs = ArticleLocatorInputs()
        let articleLocatorOutputs = ArticleLocatorOutputs()
        super.init(inputs: articleLocatorInputs, outputs: articleLocatorOutputs)
        self.changeDataState(dataState: .loading)
        listenToLocationRetreival()
        listenToSelectedArticle()
    }

    func listenToSelectedArticle() {
        store(cancellable: inputs.selectedArticleLocationSubject.map({ [weak self] (articleLocation) -> Geosearch? in
            return self?.outputs.articles.first { $0.lat == articleLocation.coordinate.latitude && $0.lon == articleLocation.coordinate.longitude }
        }).sink { [weak self] (selectedArticle) in
            self?.outputs.selectedArticle = selectedArticle
        })
    }

    func listenToLocationRetreival() {
        store(cancellable: inputs.locationRetrieved.sink(receiveValue: { [weak self] (location) in
            guard let self = self else {
                return
            }
            self.sinkWithCompletion(publisher: self.repo.loadNearbyArticles(nearbyArticlesQuery: NearbyArticlesQuery(gsradius: 10000, gscoord: location.coordinate.latitude.description + "|" + location.coordinate.longitude.description))) { (nearbyArticles) in
                self.outputs.articles = nearbyArticles.query?.geosearch ?? []
                self.outputs.mapRegion.center.latitude = location.coordinate.latitude
                self.outputs.mapRegion.center.longitude = location.coordinate.longitude
                self.outputs.articleLocations = self.outputs.articles.map { ArticleLocation(coordinate: CLLocationCoordinate2D(latitude: $0.lat ?? 0.0, longitude: $0.lon ?? 0.0))}
            }
        }))
    }
}
