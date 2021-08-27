//
//  ArticleDetailsTests.swift
//  Wikipedia LocationTests
//
//  Created by Hesham Ali on 8/27/21.
//

import XCTest
@testable import Wikipedia_Location
class ArticleDetailsTests: XCTestCase {

    var articleLocatorViewModel: ArticleLocatorViewModel!
    var articleDetailsViewModel: ArticleDetailsViewModel!
    override func setUp() {
        TestMocks.setup()
        articleLocatorViewModel = TestMocks.viewModelFactory.articleLocatorViewModel
        articleDetailsViewModel = TestMocks.viewModelFactory.articleDetailsViewModel
    }

    func testSelectedArticleAttributes() {
        let imageLoadingExpectations = XCTestExpectation(description: "Image loading expectation")
        articleLocatorViewModel.inputs.nearbyArticlesRequested.send()
        XCTAssert(!articleLocatorViewModel.outputs.articleLocations.isEmpty)
        let firstArticle = articleLocatorViewModel.outputs.articleLocations[0]
        articleLocatorViewModel.inputs.selectedArticleLocationSubject.send(firstArticle)
        let loadedArticle = articleDetailsViewModel.outputs.loadedArticleDetails
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(!self.articleDetailsViewModel.outputs.articleImages.isEmpty)
            imageLoadingExpectations.fulfill()
        }
        XCTAssert(articleDetailsViewModel.outputs.articleName == loadedArticle?.title)
        XCTAssert(articleDetailsViewModel.outputs.articleDesription == loadedArticle?.articleDescription)
        XCTAssert(articleDetailsViewModel.outputs.articleLink == loadedArticle?.fullurl)
        wait(for: [imageLoadingExpectations], timeout: 3)

    }

}
