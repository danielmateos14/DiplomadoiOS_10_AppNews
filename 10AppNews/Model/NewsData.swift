//
//  NewsData.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import Foundation

// strcuts para los datos de la API

//Crear un strcut para la api que seria la llave principal que contiene a las otras llaves, se hace articles del tipo
// Article que es donde vienen los demas elementos
struct Welcome: Codable {
    var totalResults: Int?
    var articles: [Article]
}

//Este es el struct donde viene los atributos que se van a codificar y mostrarlos en la pantalla
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
