//
//  FeaturedPlaylistCellView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeaturedPlaylistCellView: View {
    let cellModel: FeaturedPlaylistCellViewModel
    init(cellModel: FeaturedPlaylistCellViewModel) {
        self.cellModel = cellModel
    }
    var body: some View {
        VStack {
            AnimatedImage(url: cellModel.artworkURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                .padding(8)
            
            Text(cellModel.name)
                .font(.system(size: 15, weight: .regular))
                .lineLimit(2)
            Text(cellModel.creatorName)
                .font(.system(size: 13, weight: .thin))
                .lineLimit(1)
        }
        .frame(width: (UIScreen.main.bounds.width*0.5)-20, height: (UIScreen.main.bounds.height*0.25))
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(4)
    }
}

//struct FeaturedPlaylistCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeaturedPlaylistCellView()
//    }
//}
