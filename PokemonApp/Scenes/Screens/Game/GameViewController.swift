//
//  GameViewController.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - UI Components
    
    //ContainerStack
    private lazy var containerStack: UIStackView = {
        let element = UIStackView()
        //Style
        element.axis = .vertical
        element.alignment = .center
        element.distribution = .equalCentering
        element.spacing = 60
        return element
    }()
    
    //HeaderStack
    private lazy var headerStack: UIStackView = {
        let element = UIStackView()
        //Style
        element.axis = .vertical
        element.alignment = .center
        element.distribution = .fill
        element.spacing = 20
        
        return element
    }()
    
    var headertitle: UILabel = {
        var element = UILabel(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .boldSystemFont(ofSize: 26)
        element.textColor = .black
        element.text = "¿Quién es este Pokemon?"
        return element
    }()
    
    private lazy var scored: UILabel = {
        let element = UILabel(frame: .zero)
        var score = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .boldSystemFont(ofSize: 21)
        element.textColor = .black
        element.text = "Puntaje: \(score)"
        return element
    }()
    
    //PokemonStack
    private lazy var pokemonStack: UIStackView = {
        let element = UIStackView()
        //Style
        element.axis = .vertical
        element.alignment = .center
        element.distribution = .fill
        element.spacing = 20
        return element
    }()
    
    private lazy var image: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "pikachu")
        element.layout{
            $0.width == 255
            $0.height == 255
        }
        return element
    }()
    
    private lazy var result: UILabel = {
        let element = UILabel(frame: .zero)
        var pokemonName = "Pikachu"
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .boldSystemFont(ofSize: 21)
        element.textColor = .black
        element.text = "Sí, es un \(pokemonName)"
        return element
    }()

    //ButtonStack
    private lazy var buttonStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .fill
        element.distribution = .fill
        element.spacing = 20
        return element
    }()
    
    
    //Atributes
    lazy var pokemonManager = PokemonManager()
}

// MARK: - LifeCycle
extension GameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        pokemonManager.delegate = self
        setupLayout()
        pokemonManager.fetchPokemon()
    }
}

// MARK: - UI
private extension GameViewController {
    func setupLayout(){
        view.addSubview(containerStack)
        containerStack.layout{
            $0.top == view.safeAreaLayoutGuide.topAnchor + 20
            $0.bottom == view.safeAreaLayoutGuide.bottomAnchor - 20
            $0.trailing == view.trailingAnchor
            $0.leading == view.leadingAnchor
        }
        
        //Container Stack
        containerStack.addArrangedSubview(headerStack)
        containerStack.addArrangedSubview(pokemonStack)
        containerStack.addArrangedSubview(buttonStack)
        
        //Header Stack
        headerStack.addArrangedSubview(headertitle)
        headerStack.addArrangedSubview(scored)
        
        //Pokemon Stack
        pokemonStack.addArrangedSubview(image)
        pokemonStack.addArrangedSubview(result)
        
        //Button Stack
        buttonStack.layout {
            $0.trailing == view.trailingAnchor - 20
            $0.leading == view.leadingAnchor + 20
        }
    }
    
    func createOptionButton(with pokemons: [PokemonModel]){
        for pokemon in pokemons {
            let button = OptionButton()
            button.setTitle(pokemon.name, for: .normal)
            buttonStack.addArrangedSubview(button)
        }
    }
}

//MARK: - PokemonManagerDelegate
// Logica de la vista
extension GameViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        createOptionButton(with: pokemons)
        print(pokemons.choose(4))
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
