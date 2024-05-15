//
//  FavoriteNews.swift
//  AppcentNews
//
//  Created by oguzhan on 15.05.2024.
//

import SwiftUI

struct FavoriteNews: View {
    
    // ViewModel
    @StateObject private var viewModel = NewsViewModel()
    
    // Filtered Data
    var filteredData: [NewsModel] {
        viewModel.news.filter({ news in
            return Defaults.isFavorite(newsID: news.url)
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !filteredData.isEmpty {
                    List(filteredData, id: \.url) { news in
                        NewsCell(destination: NewsDetailVC(news: news), news: news)
                    }
                } else {
                    Text("There is no favorite news.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Favorites")
            .onAppear(perform: {
                viewModel.fetchNews { result in
                    switch result {
                    case .success(let newsResponse):
                        print("News fetched successfully: \(newsResponse.totalResults) results found.")
                        // Further processing or UI updates here
                    case .failure(let error):
                        print("Error fetching news: \(error.localizedDescription)")
                    }
                }
            })
        }
    }
}

struct NewsVC_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNews()
    }
}

