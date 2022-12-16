//
//  PokemonData.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import Foundation

struct PokemonData: Decodable {
    let results: [PokemonResult]?
}

struct PokemonResult: Decodable {
    let name: String?
    let url: String?
}
