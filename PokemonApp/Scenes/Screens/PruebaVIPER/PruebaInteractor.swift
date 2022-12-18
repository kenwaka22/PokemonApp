//
//  PruebaInteractor.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//  
//

import Foundation

protocol PruebaInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol PruebaInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: PruebaInteractorOutputProtocol? { get set }
    var localDatamanager: PruebaLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PruebaRemoteDataManagerInputProtocol? { get set }
}

class PruebaInteractor: PruebaInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PruebaInteractorOutputProtocol?
    var localDatamanager: PruebaLocalDataManagerInputProtocol?
    var remoteDatamanager: PruebaRemoteDataManagerInputProtocol?

}

extension PruebaInteractor: PruebaRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
