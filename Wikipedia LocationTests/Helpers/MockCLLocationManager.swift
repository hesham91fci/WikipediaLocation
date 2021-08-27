//
//  MockLocationManager.swift
//  Wikipedia LocationTests
//
//  Created by Hesham Ali on 8/27/21.
//

import Foundation
import CoreLocation
@testable import Wikipedia_Location

class MockCLLocationManager: CLLocationManager {
    var mockLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    override var location: CLLocation? {
        return mockLocation
    }
    override init() {
        super.init()
    }

    override func requestLocation() {
        self.delegate?.locationManager?(self, didUpdateLocations: [mockLocation])
    }
}
