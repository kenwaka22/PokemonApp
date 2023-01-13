//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 12/01/23.
//

import Foundation
import Alamofire

protocol PokemonRepositoryProtocol {
    static var shared: PokemonRepositoryProtocol { get }
    func getPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> ())
    func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ())
}

final class AlamofirePokemonRepository: PokemonRepositoryProtocol {
    static var shared: PokemonRepositoryProtocol = AlamofirePokemonRepository()
    private let url = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    func getPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> ())  {
        AF.request(url).responseDecodable(of: PokemonList.self) { response in
            switch response.result {
            case .success(let pokemonList):
                completion(.success(pokemonList.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.request(url).responseData { response in
            switch response.result {
            case.success(let data):
                completion(.success(data))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


final class URLSessionPokemonRepository: PokemonRepositoryProtocol {
    func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        
    }
    
    static var shared: PokemonRepositoryProtocol = URLSessionPokemonRepository()
    private let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
    private let model = PokemonList.self
    
    func getPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> ())  {
        URLSession.shared.request(urlString: self.urlString, model: model) { result in
            switch result {
            case.success(let pokemonList):
                completion(.success(pokemonList.results))
            case.failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}

