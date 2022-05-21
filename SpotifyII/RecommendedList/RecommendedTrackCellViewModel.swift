//
//  RecommendedTrackCellViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import Foundation

struct RecommendedTrackCellViewModel: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let artistName: String
    let artworkURL: URL?
    
    static func == (lhs: RecommendedTrackCellViewModel, rhs: RecommendedTrackCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
