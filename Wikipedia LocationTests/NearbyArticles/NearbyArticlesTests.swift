//
//  ArticleLocatorTests.swift
//  Wikipedia LocationTests
//
//  Created by Hesham Ali on 8/27/21.
//

import XCTest
@testable import Wikipedia_Location
class NearbyArticlesTests: XCTestCase {

    var articleLocatorViewModel: ArticleLocatorViewModel!
    override func setUp() {
        TestMocks.setup()
        articleLocatorViewModel = TestMocks.viewModelFactory.articleLocatorViewModel
    }

    func testMapRegionCenter() {
        articleLocatorViewModel.inputs.nearbyArticlesRequested.send()
        XCTAssert(articleLocatorViewModel.outputs.mapRegion.center.latitude == mockLocationManager.location?.coordinate.latitude)
        XCTAssert(articleLocatorViewModel.outputs.mapRegion.center.longitude == mockLocationManager.location?.coordinate.longitude)
    }

    func testNearbyArticles() {
        articleLocatorViewModel.inputs.nearbyArticlesRequested.send()
        XCTAssert(!articleLocatorViewModel.outputs.articles.isEmpty)
        XCTAssert(!articleLocatorViewModel.outputs.articleLocations.isEmpty)
    }

}
