//
//  AuthView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        WebView(request: viewModel.signInUrlRequest) { code in
            viewModel.fetchAuthResponse(using: code)
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let loginFetcher = AuthFetcher()
        let viewModel = AuthViewModel(loginFetcher: loginFetcher)
        AuthView(viewModel: viewModel)
    }
}
