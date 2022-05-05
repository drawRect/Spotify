//
//  NewReleasesView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 04/05/22.
//

import SwiftUI

struct NewReleasesView: View {
    private var columns = [
        GridItem(.adaptive(minimum: 200), spacing: 0),
        GridItem(.adaptive(minimum: 200), spacing: 0),
        GridItem(.adaptive(minimum: 200), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    spacing: 0
                ) {
                    ForEach(0...30, id: \.self) { _ in
                        NewReleaseCellView()
                    }
                }
            }
        }
    }
}

struct NewReleasesView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesView()
    }
}
