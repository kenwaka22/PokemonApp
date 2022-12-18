//
//  PokedexRoute.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation
import UIKit

typealias EntryPoint = PokedexViewProtocol & UIViewController

protocol PokedexRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    static func start() -> PokedexRouterProtocol
}

class PokedexRouter: PokedexRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> PokedexRouterProtocol {
        let router = PokedexRouter()
        
        //VIP
        let view: PokedexViewProtocol = PokedexView()
        let presenter: PokedexPresenterProtocol = PokedexPresenter()
        let interactor: PokedexInteractorProtocol = PokedexInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
