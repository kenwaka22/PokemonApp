//
//  PruebaPresenter.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//  
//

import Foundation

protocol PruebaPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PruebaViewProtocol? { get set }
    var interactor: PruebaInteractorInputProtocol? { get set }
    var wireFrame: PruebaWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

class PruebaPresenter  {
    
    // MARK: Properties
    weak var view: PruebaViewProtocol?
    var interactor: PruebaInteractorInputProtocol?
    var wireFrame: PruebaWireFrameProtocol?
    
}

extension PruebaPresenter: PruebaPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension PruebaPresenter: PruebaInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
