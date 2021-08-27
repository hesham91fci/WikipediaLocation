//
//  BottomSheetView.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/23/21.
//

import Foundation
import SwiftUI
import BottomSheet
struct BottomSheetWrapper<BottomSheetContent: View>: ViewModifier {

   @Binding var isPresenter: Bool
    var height: CGFloat
    var bsContent: BottomSheetContent

    func body(content: Content) -> some View {
        content
            .bottomSheet(isPresented: $isPresenter, height: height, topBarCornerRadius: 16.0) {
            self.bsContent
        }
    }
}

extension BaseView {
    func withBottomSheet<Content: View>(isPresented: Binding<Bool>, height: CGFloat, content: () -> Content) -> some View {
        self.modifier(BottomSheetWrapper(isPresenter: isPresented, height: height, bsContent: content()))
    }
}
