//
//  NewsDetailVC.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

struct NewsDetailVC: View {
    
    // Parameters
    @State var news: NewsModel
    
    // Show ActivityView Control
    @State private var isShowingActivityView = false
    
    var body: some View {
        VStack {
            CustomNavigationBar(isWebView: false, news: news) {
                isShowingActivityView = true
            } addFavorite: {
                if Defaults.isFavorite(newsID: news.url) {
                    Defaults.removeFavorite(newsID: news.url)
                } else {
                    Defaults.addFavorite(newsID: news.url)
                }
            }

            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    if let url = URL(string: news.urlToImage ?? "") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 100)
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 250)
                                    .cornerRadius(12)
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 100)
                                    .cornerRadius(12)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(news.title)
                            .font(.title3)
                            .bold()
                        
                        HStack {
                            if news.author != nil {
                                NewsInfo(imageName: "newspaper", description: news.author!)
                            }
                            
                            Spacer()
                            
                            NewsInfo(imageName: "calendar", description: news.publishedAt.formatted(Date.FormatStyle().day().month(.twoDigits).year()))
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text(news.description ?? "")
                            .font(.system(size: 16))
                        
                        Spacer()
                    }
                    
                }
                .padding([.top, .horizontal])
            }
            
            NavigationLink {
                NewsWebViewVC(url: news.url)
                    .navigationBarBackButtonHidden()
            } label: {
                Text("News Source")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1)))
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            .sheet(isPresented: $isShowingActivityView) {
                if let url = URL(string: news.url) {
                    ActivityView(activityItems: [url])
                        .presentationDetents([.medium])
                } else {
                    Text("Geçersiz URL")
                }
            }
            
        }
    }
}

struct NewsInfo: View {
    
    @State var imageName: String
    @State var description: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            Text(description)
                .foregroundColor(.gray)
        }
    }
}
