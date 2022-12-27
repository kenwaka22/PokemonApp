//
//  TabBarViewController.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 23/12/22.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    private lazy var pokedexVC = PokedexRouter.start().entry
    private lazy var gameVC = GameView()
}

// MARK: - LifeCycle
extension TabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItem()
        setupStyle()
        print("viewDidLoad TabBar")
    }
}

// MARK: - Helpers
private extension TabBarController {
    func setupTabBarItem() {
        let pokedex = templateNavigationController(unselectedImage: Images.pokedexUnselected, selectedImage: Images.pokedexSelected, rootViewController: pokedexVC ?? UIViewController())
        let game = templateNavigationController(unselectedImage: Images.game, selectedImage: nil, rootViewController: gameVC)
        viewControllers = [pokedex, game]
    }
    
    func setupStyle(){
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
    
    func templateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.backgroundColor = .white
        nav.title = nil
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .white
        
        return nav
    }
}



