//
//  HomeViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import Foundation
import Combine

enum HomeSectionType: Hashable {
    
    case newReleases
    case featuredPlaylists
    case recommendedTracks
    
    var title: String {
        switch self {
        case .newReleases: return "New Release Albums"
        case .featuredPlaylists: return "Featured Playlists"
        case .recommendedTracks: return "Recommended"
        }
    }
    
    static func == (lhs: HomeSectionType, rhs: HomeSectionType) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

class HomeViewModel: ObservableObject {
    
    private let homeFetcher: HomeFetchable
    private var disposables = Set<AnyCancellable>()
    
    var sections: [HomeSectionType] = []
    var newData: [HomeSectionType: [Any]] = [:]
    @Published var selectedSection: HomeSectionType = .newReleases
    
    init(homeFetcher: HomeFetcher) {
        self.homeFetcher = homeFetcher
        sections = [
            .newReleases,
            .featuredPlaylists,
            .recommendedTracks
        ]
    }
    
    func requestNewReleases() {
        homeFetcher.getNewReleases()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure(let error):
                    print(error)
                    break
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                self?.newData[.newReleases] = resp.albums.items.compactMap {
                    NewReleasesCellViewModel(name: $0.name,
                                             artworkURL: URL(string: $0.images.first?.url ?? ""),
                                             numberOfTracks: $0.total_tracks,
                                             artistName: $0.artists.first?.name ?? ""
                    )}
                self?.selectedSection = .newReleases
            })
            .store(in: &disposables)
    }
    
    func requestFeaturedPlaylists() {
        homeFetcher.getFeaturedPlaylists()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: break
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                let array = resp.playlists.items.compactMap {
                    FeaturedPlaylistCellViewModel(
                        name: $0.name,
                        artworkURL:URL(string: $0.images.first?.url ?? ""),
                        creatorName: $0.owner.display_name
                    )}
                self?.newData[.featuredPlaylists] = array
            })
            .store(in: &disposables)
    }
    
    private func requestRecommendataions(genres: Set<String>) {
        homeFetcher.getRecommendations(genres: genres)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure:
                    break
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                self?.newData[.recommendedTracks] = resp.tracks.compactMap({RecommendedTrackCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", artworkURL: URL(string: $0.album?.images.first?.url ?? ""))})
            })
            .store(in: &disposables)
    }
    
    func requestRecommendataionsGenres() {
        homeFetcher.getRecommendedGenres()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure:
                    break
                case .finished: break
                }
            }, receiveValue: {[weak self] resp in
                guard self != nil else { return }
                let genres = resp.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                  if let random = genres.randomElement() {
                    seeds.insert(random)
                  }
                }
                
                self?.requestRecommendataions(genres: seeds)
            })
            .store(in: &disposables)
    }
}
