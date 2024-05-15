//
//  NewsCell.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

struct NewsCell<Destination: View>: View {
    
    let destination: Destination
    @State var news: NewsModel
    
    var body: some View {
        NavigationLink {
            destination
                .navigationBarBackButtonHidden()
        } label: {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(news.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(news.description ?? "")
                        .font(.caption2)
                }
                
                Spacer()
                
                if let url = URL(string: news.urlToImage ?? "") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100)
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
            }
            .padding(.vertical, 12)
        }
    }
}
