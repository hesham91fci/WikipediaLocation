//
//  ArticleDetailsViewModel.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/24/21.
//

import Foundation
import Combine
final class ArticleDetailsInputs {
    let selectedArticleSubject: PassthroughSubject<Geosearch, Never> = PassthroughSubject()
}

final class ArticleDetailsOutputs: ObservableObject {
    @Published var articleName: String = ""
    @Published var articleDesription: String = ""
    @Published var articleImages: [String] = []
    @Published var articleLink: String = ""
    var loadedArticleDetails: PageId?
}
class ArticleDetailsViewModel: BaseViewModel<ArticleDetailsInputs, ArticleDetailsOutputs> {
    private let repo: ArticleManagerRepo!
    init(repo: ArticleManagerRepo) {
        let articleDetailsInputs = ArticleDetailsInputs()
        let articleOutputs = ArticleDetailsOutputs()
        self.repo = repo
        super.init(inputs: articleDetailsInputs, outputs: articleOutputs)
        store(cancellable: inputs.selectedArticleSubject.sink { [weak self] (article) in
            guard let self = self else {
                return
            }
            self.sinkWithCompletion(publisher: repo.loadArticleDetails(articleDetailsPostQuery: ArticleDetailsPostQuery(pageId: article.pageid?.description ?? ""))) { (articleQueryResponse) in
                self.outputs.articleImages = []
                let articlePageDetails = articleQueryResponse.query?.pages?.pageId
                self.outputs.loadedArticleDetails = articlePageDetails?[article.pageid?.description ?? ""]
                self.outputs.articleName = self.outputs.loadedArticleDetails?.title ?? ""
                self.outputs.articleDesription = self.outputs.loadedArticleDetails?.articleDescription ?? ""
                let articleImageNames = self.outputs.loadedArticleDetails?.images?.map({$0.title ?? ""}) ?? []
                self.loadImageNames(imageNames: articleImageNames)
                self.outputs.articleLink = self.outputs.loadedArticleDetails?.fullurl ?? ""
            }
        })
    }

    private func loadImageNames(imageNames: [String]) {
        DispatchQueue.main.async {
            for imageName in imageNames {
                self.sinkWithCompletion(publisher: self.repo.loadArticleImage(imageFetchQuery: ImageFetchQuery(title: imageName)), state: .none) { [weak self] (articleImageResponse) in
                    let articleImageInfoPage = articleImageResponse.query?.pages?.articleImagePages?.first?.value
                    self?.outputs.articleImages.append(articleImageInfoPage?.imageinfo?.first?.url ?? "")
                }
            }
        }
    }
}
