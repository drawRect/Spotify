//
//  NewReleasesViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import Foundation

struct NewReleasesCellViewModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let artworkURL: URL?
    let numberOfTracks: Int
    let artistName: String
    
    static func == (lhs: NewReleasesCellViewModel, rhs: NewReleasesCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
