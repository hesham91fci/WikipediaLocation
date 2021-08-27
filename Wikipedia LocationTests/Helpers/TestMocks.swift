//
//  TestMocks.swift
//  NewsTests
//
//  Created by Hesham Ali on 2/17/21.

import Foundation
@testable import Wikipedia_Location
var mockSceneDelegate: MockSceneDelegate! = nil
var mockAppCoordinator: CoordinatorProtocol {
    mockSceneDelegate.coordinator
}

var mockLocationManager: MockCLLocationManager {
    MockCLLocationManager()
}
class TestMocks {
    static var viewModelFactory: ViewModelFactoryProtocol = TestingViewModelFactory()
    static func setup() {
        mockSceneDelegate = MockSceneDelegate()
        mockAppCoordinator.start()
    }

    static func getAppError() -> AppError {
        return AppError(message: .defaultApiFaliureMessage, errorCode: -1)
    }
}

class MockSceneDelegate: SceneDelegate {
    override init() {
        super.init()
        coordinator = AppCoordinator(viewFactory: ViewFactory(viewModelFactory: TestMocks.viewModelFactory), locationManager: LocationManagerPublisher(locationManager: mockLocationManager))
    }
}
