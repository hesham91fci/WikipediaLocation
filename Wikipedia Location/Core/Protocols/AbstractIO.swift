//
//  AbstractIO.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/19/21.
//

import Foundation
import Combine
final class EmptyInputs {}
final class EmptyOutputs: ObservableObject {}

class AbstractIO<Inputs, Outputs>: NSObject, ObservableObject where Outputs: ObservableObject {
    var inputs: Inputs
    @Published var outputs: Outputs

    // subclasses must call this method in their initializer
    // swiftlint:disable force_cast
    internal init(inputs: Inputs? = nil, outputs: Outputs? = nil) {
        self.inputs = inputs ?? (EmptyInputs() as! Inputs)
        self.outputs = outputs ?? (EmptyOutputs() as! Outputs)
        super.init()
        // subscribe to outputs changes
        subscriptions.append(self.outputs.objectWillChange.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        })
    }

    var subscriptions: [AnyCancellable] = []
}
