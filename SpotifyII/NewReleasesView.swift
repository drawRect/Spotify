//
//  NewReleasesView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI

struct NewReleasesView: View {
    let newReleaseVM: [NewReleasesCellViewModel]
    init(newReleaseVM: [NewReleasesCellViewModel]) {
        self.newReleaseVM = newReleaseVM
    }
    private var columns = [
        GridItem(.flexible())
//        GridItem(.adaptive(minimum: 300), spacing: 0),
//        GridItem(.adaptive(minimum: 200), spacing: 0),
//        GridItem(.adaptive(minimum: 200), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: 0
                ) {
                    ForEach(newReleaseVM, id: \.self) { model in
                        NewReleaseCellView(cellModel: model)
                    }
                }
            }
        }
    }
}

struct NewReleasesView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesView(newReleaseVM: [NewReleasesCellViewModel(name: "Hello", artworkURL: URL(string: "https://i.scdn.co/image/ab67616d0000b2732010657a03a64e77c2538491")!, numberOfTracks: 10, artistName: "Adele")])
    }
}
