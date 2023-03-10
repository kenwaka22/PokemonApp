//
//  PokemonPresenter.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol PokedexPresenterProtocol: AnyObject {
    var view: PokedexViewProtocol? { get set }
    var interactor: PokedexInteractorProtocol? { get set }
    var router: PokedexRouterProtocol? { get set }

    func viewDidLoad()
    func interactorDidFetchPokemons(with result: Result<[Pokemon], Error>)
}

class PokedexPresenter: PokedexPresenterProtocol {
    weak var view: PokedexViewProtocol?
    var interactor: PokedexInteractorProtocol?
    var router: PokedexRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getPokemons()
    }

    func interactorDidFetchPokemons(with result: Result<[Pokemon], Error>) {
        switch result {
        case .success(let pokemons):
            view?.update(with: pokemons)
        case.failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
}
