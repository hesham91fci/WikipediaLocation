//
//  ViewsHelper.swift
//  News
//
//  Created by Hesham Ali on 8/7/21.
//

import SwiftUI
struct ActivityIndicatorView: UIViewRepresentable {

    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    var configuration = { (indicator: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        uiView.style = .medium
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicatorView {
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}

var defaultProgressView: some View {
    VStack {
        ActivityIndicatorView(isAnimating: true)
            .padding()
        Text("Loading...")
            .bold()
            .font(Font.system(size: 20))
    }
}
