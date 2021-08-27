//
//  BaseView.swift
//  News
//
//  Created by Hesham Ali on 2/10/21.
//

import SwiftUI
import Combine

struct BaseView<Content: View, Inputs, Outputs: ObservableObject, VM: BaseViewModel<Inputs, Outputs>>: View {

    @State private var isLoading: Bool = false
    private var hideMainContentOnLoading: Bool = false
    @State private var postMessageText: String = ""

    @ObservedObject var viewModel: VM
    let content: Content
    private var progressView: AnyView

    @State private var alertMessage: String = ""
    @State private var shouldShowAlert: Bool = false
    @State private var alertTitle: String = ""

    init(viewModel: VM,
         progressView: AnyView = defaultProgressView.toAnyView(),
         hideMainContentOnLoading: Bool = true,
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self.viewModel = viewModel
        self.progressView = progressView
        self.hideMainContentOnLoading = hideMainContentOnLoading
    }

    var body: some View {
        LoadingView(view: self.progressView, isLoading: _isLoading, hideMainContent: hideMainContentOnLoading) {
            content
                .alert(isPresented: $shouldShowAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                })
            .onReceive(viewModel.dataStatePublisher) { (dataState) in handleDataState(with: dataState) }
        }
    }
}

extension View {

    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.

    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
extension BaseView {

    fileprivate func handleDataState(with dataState: DataState) {
        switch dataState {
        case .loading:
            isLoading = true
        case .finished, .none:
            isLoading = false
        case .success(message: let msg):
            isLoading = false
            shouldShowAlert = true
            alertTitle = "Success"
            alertMessage = msg
            viewModel.clearDataState()

        case .error(err: let err):
            let errorMessage = err.message ?? ApiErrorMessages.defaultApiFaliureMessage.rawValue
            shouldShowAlert = true
            alertTitle = "Error"
            alertMessage = errorMessage
            viewModel.clearDataState()

        }
    }

}
