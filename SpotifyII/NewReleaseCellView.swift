//
//  NewReleaseCellView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewReleaseCellView: View {
    
    let cellModel: NewReleasesCellViewModel
    init(cellModel: NewReleasesCellViewModel) {
        self.cellModel = cellModel
    }
    
    var body: some View {
        HStack {
            AnimatedImage(url: cellModel.artworkURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .background(Color.red)
                .cornerRadius(8)
                .padding(8)
            VStack(alignment: .leading, spacing: 8) {
                Text(cellModel.name)
                    .font(.system(size: 20, weight: .semibold))
                    .lineLimit(1)
                Text(cellModel.artistName)
                    .font(.system(size: 18, weight: .light))
                Text("Tracks: \(cellModel.numberOfTracks)")
                    .font(.system(size: 18, weight: .thin))
            }
            .lineLimit(2)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(4)
    }
}

struct NewReleaseCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleaseCellView(cellModel: NewReleasesCellViewModel(name: "Hello", artworkURL: URL(string: "https://i.scdn.co/image/ab67616d0000b2732010657a03a64e77c2538491")!, numberOfTracks: 5, artistName: "Adele"))
    }
}
