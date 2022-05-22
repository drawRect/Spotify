//
//  RecommededPlaylistCellView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 21/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecommededPlaylistCellView: View {
    let cellModel: RecommendedTrackCellViewModel
    init(cellModel: RecommendedTrackCellViewModel) {
        self.cellModel = cellModel
    }
    var body: some View {
        HStack {
            HStack {
                AnimatedImage(url: cellModel.artworkURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .padding(8)
            }
            VStack {
                Text(cellModel.name)
                    .font(.system(size: 18, weight: .regular))
                Text(cellModel.artistName)
                    .font(.system(size: 15, weight: .thin))
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(4)
    }
}

struct RecommededPlaylistCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecommededPlaylistCellView(cellModel: RecommendedTrackCellViewModel(name: "Hello", artistName: "Adele", artworkURL: nil))
    }
}
