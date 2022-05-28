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
            VStack {
                AnimatedImage(url: cellModel.artworkURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .padding(8)
            }
            VStack(alignment: .leading) {
                Text(cellModel.name)
                    .font(.system(size: 18, weight: .regular))
                    .lineLimit(2)
                Text(cellModel.artistName)
                    .font(.system(size: 15, weight: .thin))
                    .lineLimit(1)
            }
        }
        .frame(width: (UIScreen.main.bounds.width-(2*50)), alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(5)
    }
}

struct RecommededPlaylistCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecommededPlaylistCellView(cellModel: RecommendedTrackCellViewModel(name: "Hello", artistName: "Adele", artworkURL: nil))
    }
}
