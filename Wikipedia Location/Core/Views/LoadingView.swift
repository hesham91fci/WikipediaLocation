//
//  ProgressView.swift
//  News
//
//  Created by Hesham Ali on 8/1/21.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    private let content: Content
    private let progressView: AnyView
    @State private var isLoading: Bool = false
    private var hideMainContent: Bool

    init(view progressView: AnyView, isLoading: State<Bool>, hideMainContent: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.progressView = progressView
        self._isLoading = isLoading
        self.hideMainContent = hideMainContent
    }

    var body: some View {
        ZStack {
            content.isHidden(self.isLoading && self.hideMainContent )
            progressView.isHidden(!self.isLoading)
        }
    }
}
