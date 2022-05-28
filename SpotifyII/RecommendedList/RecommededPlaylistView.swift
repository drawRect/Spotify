//
//  RecommededPlaylistView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 05/05/22.
//

import SwiftUI

struct RecommededPlaylistView: View {
    let vm: [RecommendedTrackCellViewModel]
    init(vm: [RecommendedTrackCellViewModel]) {
        self.vm = vm
    }
    var body: some View {
        List {
            ForEach(vm, id: \.self) { item in
                RecommededPlaylistCellView(cellModel: item)
                    .listRowSeparator(.hidden)
            }
            .environment(\.defaultMinListRowHeight, 90)
        }
    }
}

//struct RecommededPlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommededPlaylistView()
//    }
//}
