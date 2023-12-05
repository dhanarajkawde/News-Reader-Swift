//
//  News.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let message: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
}
