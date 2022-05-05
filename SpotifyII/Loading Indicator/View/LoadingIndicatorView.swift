//
//  LoadingIndicatorView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI

struct LoadingIndicatorView: View {

    @ObservedObject private var viewModel: LoadingIndicatorViewModel

    init(viewModel: LoadingIndicatorViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLoading {
            HStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: viewModel.color))
                Spacer()
                    .frame(width: 8)
                Text(viewModel.displayedText)
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
    }
}
