//
//  GameInteractor.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 12/01/23.
//  
//

import Foundation

protocol GameInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: GameInteractorOutputProtocol? { get set }
    
    func getPokemons()
    func checkAnswer(pokemonName: String)
    func getPokemonOptions()
    func newGame()
    func getHistory() -> ([Pokemon], Int)
}

class GameInteractor {

    // MARK: - Attributes
    weak var presenter: GameInteractorOutputProtocol?
    private let repository: PokemonRepositoryProtocol = AlamofirePokemonRepository.shared
    
    private var pokemons = [Pokemon]()
    private var pokemonAnswer: Pokemon?
    private var history = [Pokemon]()
    private var score: Int = 0
    private var isGameActive: Bool = true
    
    // MARK: - Private Methods
    
}

// MARK: - GameInteractorInputProtocol
extension GameInteractor: GameInteractorInputProtocol {
    func getPokemons() {
        repository.getPokemonList { result in
            switch result {
            case.success(let pokemons):
                self.pokemons = pokemons
                self.getPokemonOptions()
                self.presenter?.showScore(self.score)
            case.failure(let error):
                self.presenter?.showError(error)
            }
        }
    }
    
    func getPokemonOptions() {
        let number = 4
        let randomIndex = Int.random(in: 0...number - 1)
        let pokemonOptions = pokemons.choose(number)
        pokemonAnswer = pokemonOptions[randomIndex]
        
        guard let pokemonAnswer = pokemonAnswer else { return }
        guard let url = pokemonAnswer.imageUrl else { return }
        
        self.presenter?.showPokemonOptions( pokemonOptions.map({ $0.name }) )
        self.presenter?.showShadowImage(url)
    }
    
    func checkAnswer(pokemonName: String) {
        guard let url = pokemonAnswer?.imageUrl else {
            fatalError("[KW] GameInteractor - checkAnswer - Invalid URL ") }

        var isCorrect: Bool
        if pokemonName.capitalized == pokemonAnswer?.name.capitalized {
            isCorrect = true
            self.score += 1
        } else {
            isCorrect = false
            isGameActive = false
        }
        
        
        guard let pokemonAnswer = pokemonAnswer else { return }
        
        history.append(pokemonAnswer)
        presenter?.showAnswer(isCorrect: isCorrect, name: pokemonAnswer.name.capitalized, url: url)
        presenter?.showScore(self.score)
    }
    
    func newGame() {
        //Set Default variables
        if !isGameActive {
            history = [Pokemon]()
            score = 0
            self.getPokemonOptions()
            self.presenter?.showScore(self.score)
        }
    }
    
    func getHistory() -> ([Pokemon], Int) {
        return (history, score)
    }

}
