//
//  MainRepo.swift
//  News
//
//  Created by Hesham Ali on 2/4/21.
//

import Foundation
import Combine
class BaseRepo {
    private var subscriptions: [AnyCancellable] = []
    var networkHandler: NetworkHandler

    init(networkHandler: NetworkHandler = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
}
