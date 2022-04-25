//
//  NewsData.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import Foundation

// strcuts para los datos de la API

struct Welcome: Codable {
    var totalResults: Int?
    var articles: [Article]
}

struct Article: Codable {
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var source: Source
}

struct Source: Codable {
    var name: String?
}
