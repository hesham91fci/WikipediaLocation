//
//  ArticleDetails.swift
//  Wikipedia Location
//
//  Created by Hesham Ali on 8/24/21.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.DefaultImageProcessor
struct ArticleDetailsView: View {
    @ObservedObject var articleDetailsViewModel: ArticleDetailsViewModel
    var body: some View {
        BaseView(viewModel: articleDetailsViewModel) {
            return VStack(alignment: .leading, spacing: 16) {
                Text(articleDetailsViewModel.outputs.articleName)
                Text(articleDetailsViewModel.outputs.articleDesription)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(articleDetailsViewModel.outputs.articleImages, id: \.self) { imageUrl in
                            let imageUrl = URL(string: imageUrl)
                            KFImage(imageUrl, options: [.keepCurrentImageWhileLoading, imageUrl?.description.hasSuffix(".svg") ?? false ? .processor(SVGImgProcessor()) : .processor(DefaultImageProcessor.default)])
                                .placeholder {
                                    Image("placeholderImage")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                }
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                    }

                }
                Text("Wikipedia").font(.footnote).foregroundColor(Color.blue).underline().onTapGesture {
                    guard let articleUrl = URL(string: articleDetailsViewModel.outputs.articleLink) else {
                        return
                    }
                    UIApplication.shared.open(articleUrl, options: [:])
                }
            }.padding(8)
        }
    }
}
