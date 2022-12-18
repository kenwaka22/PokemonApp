//
//  PruebaWireFrame.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//  
//

import Foundation
import UIKit

protocol PruebaWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createPruebaModule() -> UIViewController
}

class PruebaWireFrame: PruebaWireFrameProtocol {

    class func createPruebaModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PruebaView")
        if let view = navController.children.first as? PruebaView {
            let presenter: PruebaPresenterProtocol & PruebaInteractorOutputProtocol = PruebaPresenter()
            let interactor: PruebaInteractorInputProtocol & PruebaRemoteDataManagerOutputProtocol = PruebaInteractor()
            let localDataManager: PruebaLocalDataManagerInputProtocol = PruebaLocalDataManager()
            let remoteDataManager: PruebaRemoteDataManagerInputProtocol = PruebaRemoteDataManager()
            let wireFrame: PruebaWireFrameProtocol = PruebaWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "PruebaView", bundle: Bundle.main)
    }
    
}
