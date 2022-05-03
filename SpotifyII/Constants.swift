//
//  Constants.swift
//  SpotifyII
//
//  Created by BKS-GGS on 21/04/22.
//

import Foundation

struct Constants {
    private static let bundleInfo = Bundle.main.infoDictionary
    
    static var clientId: String {
        guard let key = bundleInfo?["clientId"] as? String else {
            fatalError("clientId not found")
        }
        return key
    }
    static var clientSecret: String {
        guard let key = bundleInfo?["clientSecret"] as? String else {
            fatalError("clientSecret not found")
        }
        return key
    }
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let redirectURI = "https://github.com/ranmyfriend"
    static let scopes = """
                            user-read-private\
                            %20playlist-modify-public\
                            %20playlist-read-private\
                            %20playlist-modify-private\
                            %20user-follow-read\
                            %20user-follow-modify\
                            %20user-library-read\
                            %20user-read-email\
                            %20user-library-modify
                            """
}
