//
//  WebView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    private let request: URLRequest
    private let authExchangeCode: ((String) -> Void)
    
    init(request: URLRequest, authExchangeCode: @escaping (String)->Void) {
        self.request = request
        self.authExchangeCode = authExchangeCode
    }
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        return WKWebView(frame: .zero, configuration: config)
    }()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        uiView.load(request)
    }
    
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            guard let url = webView.url else {
                return
            }
            // Exchange the code for access token
            let component = URLComponents(string: url.absoluteString)
            guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else {
                return
            }
            print("exchange.code:\(code)")
            
            webView.isHidden = true
            parent.authExchangeCode(code)
        }
    }
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!)) { code in
            print(code)
        }
    }
}
#endif
