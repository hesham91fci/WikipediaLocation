//
//  LocationManager.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/19/21.
//

import Foundation
import Combine
import CoreLocation

final class LocationManagerInputs {
    let locationRequested: PassthroughSubject<Void, Never> = PassthroughSubject()
}

final class LocationManagerOutputs: ObservableObject {
    let locationsSubject: PassthroughSubject<[CLLocation], Never> = PassthroughSubject()
}

class LocationManagerPublisher: AbstractIO<LocationManagerInputs, LocationManagerOutputs>, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager!
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        let locationManagerInputs = LocationManagerInputs()
        let locationManagerOutputs = LocationManagerOutputs()
        super.init(inputs: locationManagerInputs, outputs: locationManagerOutputs)

        inputs.locationRequested.sink { [weak self] (_) in
            self?.locationManager.delegate = self
            locationManager.requestLocation()
        }.store(in: &subscriptions)
    }

  func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        outputs.locationsSubject.send(locations)
  }
  func locationManager(_: CLLocationManager, didFailWithError error: Error) {
    locationManager.requestAlwaysAuthorization()
    print("failed \(error)")
  }
  func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
        locationManager.requestLocation()
    }
    if status == .notDetermined {
        locationManager.requestAlwaysAuthorization()
    }
  }
}
