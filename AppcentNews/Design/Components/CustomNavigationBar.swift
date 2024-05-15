//
//  CustomNavigationBar.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    @State var isWebView: Bool = false
    @State private var isFavorite: Bool?
    @State var title: String = "News Source"
    
    @State var news: NewsModel?
    
    var shareButtonAction: () -> () = {}
    var addFavorite: () -> () = {}
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(alignment: isWebView ? .center : .bottom, spacing: 16) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            })
            
            Spacer()
            
            if isWebView {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            if !isWebView {
                Button(action: {
                    // Share
                    shareButtonAction()
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.black)
                })
            }
            
            if isWebView {
                Spacer()
            }
            
            Button(action: {
                // Add - Remove Favorite
                addFavorite()
                isFavorite = Defaults.isFavorite(newsID: news?.url ?? "")
            }, label: {
                Image(systemName: isFavorite ?? false ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundColor(.black)
            })
            .disabled(isWebView)
            .opacity(isWebView ? 0 : 1)
        }
        .padding()
        .onAppear(perform: {
            isFavorite = Defaults.isFavorite(newsID: news?.url ?? "")
        })
    }
}

