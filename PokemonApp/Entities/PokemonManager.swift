//
//  PokemonManager.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 16/12/22.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    
    private let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=151"

    var delegate: PokemonManagerDelegate?
    
    public func fetchPokemon() {
        performRequest(with: pokemonURL)
    }
    
    private func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print("error")
                    //print(error!)
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData) {
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                        print("safeData")
                        //print(pokemon)
                    }
                }
            }
            //4. Start the Task
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map({ pokemonResult in
                PokemonModel(name: pokemonResult.name ?? "", imageURL: pokemonResult.url ?? "")
            })
            
            return pokemon
        } catch {
            return nil
        }
        
    }
}
