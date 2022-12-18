//
//  PokedexInteractor.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation

protocol PokedexInteractorProtocol: AnyObject {
    var presenter: PokedexPresenterProtocol? { get set }
    
    func getPokemons()
}

class PokedexInteractor: PokedexInteractorProtocol {
    weak var presenter: PokedexPresenterProtocol?
        
    func getPokemons() {
        //Consumo de la API
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchPokemons(with: .failure(FetchError.failed))
                return
            }

            do {
                print("Success")
                let entities = try JSONDecoder().decode(PokemonData.self, from: data)
                self?.presenter?.interactorDidFetchPokemons(with: .success(entities.results ?? []))
            } catch {
                print("Error")
                self?.presenter?.interactorDidFetchPokemons(with: .failure(error))
            }
        }
        task.resume()
    }
}
