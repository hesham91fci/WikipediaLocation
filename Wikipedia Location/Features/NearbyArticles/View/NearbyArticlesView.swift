//
//  NearbyArticlesView.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/18/21.
//

import SwiftUI
import MapKit
struct NearbyArticlesView: View {
    @State private var isArticleSelected: Bool = false
    @ObservedObject var articlesLocatorViewModel: ArticleLocatorViewModel
    var body: some View {
        GeometryReader { geometry in
            BaseView(viewModel: articlesLocatorViewModel) {
                Map(coordinateRegion: $articlesLocatorViewModel.outputs.mapRegion, showsUserLocation: true, annotationItems: articlesLocatorViewModel.outputs.articleLocations) { articleLocation in
                    MapAnnotation(coordinate: articleLocation.coordinate) {
                        Image("locationIcon")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .onTapGesture {
                                if !isArticleSelected {
                                    articlesLocatorViewModel.inputs.selectedArticleLocationSubject.send(articleLocation)
                                }
                                isArticleSelected.toggle()
                            }

                    }

                }
            }.withBottomSheet(isPresented: $isArticleSelected, height: geometry.size.height/2.5, content: {
                articlesLocatorViewModel.outputs.shownView
            }).onAppear {
                self.articlesLocatorViewModel.inputs.nearbyArticlesRequested.send()
            }
        }

    }
}

struct NearbyArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()
        return NearbyArticlesView(articlesLocatorViewModel: viewModelFactory.articleLocatorViewModel)
    }
}
