//
//  Response.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import Foundation


struct Response: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}

