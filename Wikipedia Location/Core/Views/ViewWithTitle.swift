//
//  ViewWithTitle.swift
//  News
//
//  Created by Hazem Abdelfattah on 6/7/21.

//

import Foundation
import SwiftUI

struct ViewWithTitle: ViewModifier {

    var title: String

    func body(content: Content) -> some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.largeTitle)
                .frame(alignment: .center)
                .padding(.top, 16)
            Divider()
                .background(Color.black)
                .frame(height: 1)
                .padding(.top, 8)
            content
        }
    }

}

extension View {
    func withTitle(title: String) -> some View {
        self.modifier(ViewWithTitle(title: title))
    }
}
