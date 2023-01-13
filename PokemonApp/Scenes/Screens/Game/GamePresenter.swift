//
//  GamePresenter.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 12/01/23.
//  
//

import Foundation

protocol GamePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: GameViewProtocol? { get set }
    var interactor: GameInteractorInputProtocol? { get set }
    var router: GameRouterProtocol? { get set }
    
    func viewDidLoad()
    func checkAnswer(pokemonName: String)
    func getNewOptions()
    func showGameOverView()
    func newGame()
}

protocol GameInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func showPokemonOptions(_ pokemonOptions: [String])
    func showShadowImage(_ url: URL)
    func showError(_ error: Error)
    func showAnswer(isCorrect: Bool, name: String, url: URL)
    func showScore(_ score: Int)
}

class GamePresenter  {
    
    // MARK: - Attributes
    weak var view: GameViewProtocol?
    var interactor: GameInteractorInputProtocol?
    var router: GameRouterProtocol?
    
    // MARK: - Private Methods
}

// MARK: - GamePresenterProtocol
extension GamePresenter: GamePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        self.interactor?.getPokemons()
    }
    
    func checkAnswer(pokemonName: String) {
        self.interactor?.checkAnswer(pokemonName: pokemonName)
    }
    
    func getNewOptions() {
        self.interactor?.getPokemonOptions()
    }
    
    func showGameOverView() {
        var history: [Pokemon]
        var score: Int
        (history, score) = self.interactor?.getHistory() ?? ([Pokemon](), 0)
        self.router?.navigateToGameOver(pokemons: history, score: score)
    }
    
    func newGame() {
        self.interactor?.newGame()
    }
}

// MARK: - GameInteractorOutputProtocol
extension GamePresenter: GameInteractorOutputProtocol {
    func showPokemonOptions(_ pokemonOptions: [String]) {
        self.view?.displayPokemonOptions(pokemonOptions)
    }
    
    func showError(_ error: Error){
        self.view?.displayAlert(with: error)
    }
    
    func showShadowImage(_ url: URL) {
        self.view?.displayShadowImage(url: url)
    }
    
    func showAnswer(isCorrect: Bool, name: String, url: URL) {
        view?.displayAnswer(isCorrect: isCorrect, name: name, url: url)
    }
    
    func showScore(_ score: Int) {
        view?.displayScore(score)
    }
}
