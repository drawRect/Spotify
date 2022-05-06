//
//  HomeViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import Foundation
import Combine

enum HomeSectionType: Hashable {
    static func == (lhs: HomeSectionType, rhs: HomeSectionType) -> Bool {
        lhs.title == rhs.title
    }
    
    case newReleases(viewModels: [NewReleasesCellViewModel])
    case featuredPlaylists(viewModels: [FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel])
    
    var title: String {
        switch self {
        case .newReleases: return "New Release Albums"
        case .featuredPlaylists: return "Featured Playlists"
        case .recommendedTracks: return "Recommended"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

class HomeViewModel: ObservableObject {
    
    private let homeFetcher: HomeFetchable
    private var disposables = Set<AnyCancellable>()
    
    var sections: [HomeSectionType] = []
//    = [
//        .newReleases(viewModels: []),
//        .featuredPlaylists(viewModels: []),
//        .recommendedTracks(viewModels: [])
//    ]
    
    init(homeFetcher: HomeFetcher) {
        self.homeFetcher = homeFetcher
    }
    
    func requestNewReleases(completion: @escaping ((NewReleasesResponse?) -> Void)) {
        homeFetcher.getNewReleases()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure:
                    completion(nil)
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                completion(resp)
            })
            .store(in: &disposables)
    }
    
    func requestFeaturedPlaylists(completion: @escaping ((FeaturedPlaylistsResponse?) -> Void)) {
        homeFetcher.getFeaturedPlaylists()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure:
                    completion(nil)
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                completion(resp)
            })
            .store(in: &disposables)
    }
    
    
}
