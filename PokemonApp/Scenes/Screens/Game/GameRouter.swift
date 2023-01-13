//
//  GameRouter.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 12/01/23.
//  
//

import Foundation
import UIKit

protocol GameRouterProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    var view: UIViewController? { get set }
    func navigateToGameOver(pokemons: [Pokemon], score: Int)
}

class GameRouter: GameRouterProtocol {
    weak var view: UIViewController?

    func navigateToGameOver(pokemons: [Pokemon], score: Int){
        let vc = GameOverView(pokemons: pokemons, score: score)
        
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
