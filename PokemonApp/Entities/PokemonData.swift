//
//  PokemonData.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import Foundation

struct PokemonData: Codable {
    let results: [PokemonResult]?
}

struct PokemonResult: Codable {
    let name: String?
    let url: String?
}
