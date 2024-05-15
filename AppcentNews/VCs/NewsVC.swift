//
//  NewsVC.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

struct NewsVC: View {
    
    // Search Text
    @State var searchText: String = ""
    
    // ViewModel
    @StateObject private var viewModel = NewsViewModel()
    
    // Filtered Data
    var filteredData: [NewsModel] {
        if searchText.isEmpty {
            return viewModel.news
        } else {
            return viewModel.news.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(filteredData, id: \.url) { news in
                    NewsCell(destination: NewsDetailVC(news: news), news: news)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Appcent NewsApp")
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
