//
//  PruebaView.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//  
//

import Foundation
import UIKit

protocol PruebaViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PruebaPresenterProtocol? { get set }
}

class PruebaView: UIViewController {

    // MARK: Properties
    var presenter: PruebaPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PruebaView: PruebaViewProtocol {
    // TODO: implement view output methods
}
