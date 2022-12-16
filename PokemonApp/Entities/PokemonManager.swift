//
//  PokemonManager.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 16/12/22.
//

import Foundation

struct PokemonManager {
    let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData) {
                        print(pokemon)
                    }
                }
            }
            //4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(pokemonData: Data) -> [PokemonModel]? {
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
