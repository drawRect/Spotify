//
//  FeaturedPlaylistsView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI

struct FeaturedPlaylistsView: View {
    let vm: [FeaturedPlaylistCellViewModel]
    init(vm: [FeaturedPlaylistCellViewModel]) {
        self.vm = vm
    }
    private var columns = [
        GridItem(.adaptive(minimum: (UIScreen.main.bounds.width*0.5)), spacing: 0),
        GridItem(.adaptive(minimum: (UIScreen.main.bounds.width*0.5)), spacing: 0),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: 0
            ) {
                ForEach(vm, id: \.self) {
                    FeaturedPlaylistCellView(cellModel: $0)
                }
            }
        }
    }
}

//struct FeaturedPlaylistsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeaturedPlaylistsView()
//            .previewDevice("iPhone 13 Pro Max")
//    }
//}
