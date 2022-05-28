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
            VStack(alignment: .center) {
                HStack {
                    AnimatedImage(url: cellModel.artworkURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        .padding(8)
                }
                HStack {
                    VStack(alignment: .center, spacing: 8) {
                        Text(cellModel.name)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(2)
                        Text(cellModel.artistName)
                            .font(.system(size: 13, weight: .light))
                        Text("Tracks: \(cellModel.numberOfTracks)")
                            .font(.system(size: 12, weight: .thin))
                    }
                    .padding(2)
                    .lineLimit(2)
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width*0.5)-20, height: (UIScreen.main.bounds.height*0.3))
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(10)
    }
}

struct NewReleaseCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleaseCellView(cellModel: NewReleasesCellViewModel(name: "Hello", artworkURL: URL(string: "https://i.scdn.co/image/ab67616d0000b2732010657a03a64e77c2538491")!, numberOfTracks: 5, artistName: "Adele"))
    }
}
