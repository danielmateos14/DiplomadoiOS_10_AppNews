//
//  Model.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import Foundation

protocol ModelProtocol{
    func protocolFunction()
}

struct Model{
    
//    Variabel delegado que sera del tipo model protocol
    var delegate: ModelProtocol?
    
    var arrayArticles =  [Article]()
    
    mutating func ApiCreate(recibeString: String){
        let urlString = recibeString
        if let urlAPartirDeUrlString = URL(string: urlString){
            if let dataDeLaUrl = try? Data(contentsOf: urlAPartirDeUrlString){
                decodificaDatosJson(recibeUnData: dataDeLaUrl)
            }
        }
    }
    
    mutating func decodificaDatosJson(recibeUnData: Data){
        let deco = JSONDecoder()
        if let listaElementosQueHabra = try? deco.decode(Welcome.self, from: recibeUnData){
            
//            print(listaElementosQueHabra.totalResults ?? 0)
            
            arrayArticles = listaElementosQueHabra.articles
            
//            print(arrayArticles[0].title ?? "No hay nada")
        }
    }
    
    
    
}
