//
//  LoadingIndicatorViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI

class LoadingIndicatorViewModel: ObservableObject {
    @Published var displayedText: String
    @Published var isLoading: Bool
    @Published var color: Color

    init(displayedText: String, isLoading: Bool, color: Color) {
        self.displayedText = displayedText
        self.isLoading = isLoading
        self.color = color
    }
}
