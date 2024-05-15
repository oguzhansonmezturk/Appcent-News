//
//  NewsWebViewVC.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI
import WebKit

struct NewsWebViewVC: View {
    
    @State var url: String
    
    var body: some View {
        VStack {
            CustomNavigationBar(isWebView: true)
            
            WebView(url: URL(string: url)!)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

