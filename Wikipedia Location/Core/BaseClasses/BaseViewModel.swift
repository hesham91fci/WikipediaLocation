//
//  BaseViewModel.swift
//  News
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine

class BaseViewModel<Inputs, Outputs>: AbstractIO<Inputs, Outputs> where Outputs: ObservableObject {
    private(set) var dataStateSubject: CurrentValueSubject<DataState, Never> = CurrentValueSubject<DataState, Never>(.none)
    let closeCurrentViewSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()

    deinit {
        subscriptions.removeAll()
    }

}

extension BaseViewModel {

    func cancellableSinkWithCompletion<T>(publisher: AnyPublisher<T, AppError>, receiveValue: @escaping ((T) -> Void), state: DataState = .loading) -> AnyCancellable {
        return publisher
            .handleEvents(receiveRequest: { [weak self] _ in self?.changeDataState(dataState: state) })
            .sink(
            receiveCompletion: { [weak self] (completion) in
                self?.handleSubscriberCompletion(completion) }, receiveValue: receiveValue)
    }

    func sinkWithCompletion<T>(publisher: AnyPublisher<T, AppError>, state: DataState = .loading, receiveValue: @escaping ((T) -> Void) = { _ in }) {
        cancellableSinkWithCompletion(publisher: publisher, receiveValue: receiveValue, state: state)
            .store(in: &subscriptions)
    }

    func store(cancellable: AnyCancellable) {
        cancellable.store(in: &subscriptions)
    }

    private func handleSubscriberCompletion(_ completion: Subscribers.Completion<AppError>) {
        switch completion {
        case .failure(let appError):
            self.dataStateSubject.send(.error(err: appError))
        default:
            self.dataStateSubject.send(.finished)
        }
    }
}

extension BaseViewModel {

    public var dataStatePublisher: AnyPublisher<DataState, Never> {
        return dataStateSubject.eraseToAnyPublisher()
    }

    func sendError(error: AppError) {
        self.dataStateSubject.send(.error(err: error))
    }

    func changeDataState(dataState: DataState) {
        self.dataStateSubject.send(dataState)
    }

    func clearDataState() {
        dataStateSubject.send(.none)
    }
}

extension BaseViewModel {
    func closeCurrentView() {
        self.closeCurrentViewSubject.send()
    }
}
