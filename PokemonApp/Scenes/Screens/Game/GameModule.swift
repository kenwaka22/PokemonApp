//
//  GameModule.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 12/01/23.
//  
//

import Foundation
import UIKit

protocol GameModuleProtocol: AnyObject {
    var view: GameViewProtocol { get set }
    var presenter: GamePresenterProtocol & GameInteractorOutputProtocol { get set }
    var router: GameRouterProtocol { get set }
    var interactor: GameInteractorInputProtocol { get set }
}

class GameModule: GameModuleProtocol {
    var view: GameViewProtocol
    var presenter: GamePresenterProtocol & GameInteractorOutputProtocol
    var router: GameRouterProtocol
    var interactor: GameInteractorInputProtocol
    
    init(){
        self.view = GameView()
        self.presenter = GamePresenter()
        self.interactor = GameInteractor()
        self.router = GameRouter()
        
        self.view.presenter = presenter
        self.presenter.view = view
        self.presenter.router = router
        self.presenter.interactor = interactor
        self.interactor.presenter = presenter
        self.router.view = view as? UIViewController 
    }
}
