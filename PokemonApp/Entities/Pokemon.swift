//
//  PokemonData.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import Foundation

struct PokemonList: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let urlString: String
    
    var id: Int? {
        return Int(urlString.split(separator: "/").last?.description ?? "0")
    }
    
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
        //return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/\(id ?? 0).svg")
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}
