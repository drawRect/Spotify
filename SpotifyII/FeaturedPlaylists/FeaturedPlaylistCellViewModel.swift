//
//  FeaturedPlaylistCellViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import Foundation

struct FeaturedPlaylistCellViewModel: Identifiable, Hashable {
    let id = UUID()
    
    let name: String
    let artworkURL: URL?
    let creatorName: String
    static func == (lhs: FeaturedPlaylistCellViewModel, rhs: FeaturedPlaylistCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
