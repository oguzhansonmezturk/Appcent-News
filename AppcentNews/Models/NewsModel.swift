//
//  NewsModel.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsModel]
}

struct NewsModel: Decodable, Hashable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String

    static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
        return lhs.url == rhs.url && lhs.title == rhs.title && lhs.publishedAt == rhs.publishedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
        hasher.combine(title)
        hasher.combine(publishedAt)
    }
}

struct Source: Decodable {
    let id: String?
    let name: String
}







    
    
