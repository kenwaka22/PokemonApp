//
//  PruebaRemoteDataManager.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//  
//

import Foundation

protocol PruebaRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PruebaRemoteDataManagerOutputProtocol? { get set }
}

protocol PruebaRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

class PruebaRemoteDataManager:PruebaRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PruebaRemoteDataManagerOutputProtocol?
    
}
