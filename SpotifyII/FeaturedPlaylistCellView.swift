//
//  FeaturedPlaylistCellView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI

struct FeaturedPlaylistCellView: View {
    var body: some View {
        VStack {
            Image(systemName: "music.quarternote.3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.red)
            
            Text("'90s Baby Makers")
                .font(.system(size: 18, weight: .regular))
            Text("Spotify")
                .font(.system(size: 15, weight: .thin))
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(4)
    }
}

struct FeaturedPlaylistCellView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPlaylistCellView()
    }
}
