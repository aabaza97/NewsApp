//
//  Article.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}
