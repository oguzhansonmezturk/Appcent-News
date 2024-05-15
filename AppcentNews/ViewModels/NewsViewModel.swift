//
//  NewsViewModel.swift
//  AppcentNews
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news: [NewsModel] = []

    func fetchNews(completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4896cf306a644b14ab91a00115d7b6cf"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                var newsSet = Set<NewsModel>()
                for news in newsResponse.articles {
                    newsSet.insert(news)
                }
                let sortedNews = Array(newsSet).sorted(by: { $0.publishedAt > $1.publishedAt })
                DispatchQueue.main.async {
                    self.news = sortedNews
                }
                completion(.success(newsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
