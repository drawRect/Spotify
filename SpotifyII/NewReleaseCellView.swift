//
//  NewReleaseCellView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI

struct NewReleaseCellView: View {
    var body: some View {
        HStack {
            Image(systemName: "music.quarternote.3")
                .aspectRatio(contentMode: .fill)
                .background(Color.red)
                .cornerRadius(8)
                .padding(8)
            VStack(alignment: .leading, spacing: 8) {
                Text("I NEVER LIKED YOU")
                    .font(.system(size: 20, weight: .semibold))
                Text("Future")
                    .font(.system(size: 18, weight: .light))
                Text("Tracks: 16")
                    .font(.system(size: 18, weight: .thin))
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(4)
    }
}

struct NewReleaseCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleaseCellView()
    }
}
