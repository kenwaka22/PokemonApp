//
//  GameViewController.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import UIKit
import Kingfisher

protocol GameViewProtocol: AnyObject {
    var presenter: GamePresenterProtocol? { get set }
    
    func displayAlert(with error: Error)
    func displayPokemonOptions(_ pokemons: [String])
    func displayShadowImage(url: URL)
    func displayAnswer(isCorrect: Bool, name: String, url: URL)
    func displayScore(_ score: Int)
}

final class GameView: UIViewController {
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
    
    private lazy var scoreLabel: UILabel = {
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
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "pikachu")
        element.layout{
            $0.width == 255
            $0.height == 255
        }
        return element
    }()
    
    private lazy var resultLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .boldSystemFont(ofSize: 21)
        element.textColor = .black
        element.text = ""
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
    
    //OptionBtn
    private lazy var optionBtn1 = OptionButton()
    private lazy var optionBtn2 = OptionButton()
    private lazy var optionBtn3 = OptionButton()
    private lazy var optionBtn4 = OptionButton()
        
    //MARK: - Attributes
    var presenter: GamePresenterProtocol?
    var sender: UIButton?
    
    //MARK: - Methods
    @objc func didOptionBtnTapped(_ sender: UIButton){
        self.sender = sender
        let name = sender.title(for: .normal)
        guard let name = name else { return }
        setupBtns()
        presenter?.checkAnswer(pokemonName: name)
    }
    
    //UI Methods
    private func setupLayout(){
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
        headerStack.addArrangedSubview(scoreLabel)
        
        //Pokemon Stack
        pokemonStack.addArrangedSubview(imageView)
        pokemonStack.addArrangedSubview(resultLabel)
        
        //Button Stack
        buttonStack.layout {
            $0.trailing == view.trailingAnchor - 20
            $0.leading == view.leadingAnchor + 20
        }
        buttonStack.addArrangedSubview(optionBtn1)
        buttonStack.addArrangedSubview(optionBtn2)
        buttonStack.addArrangedSubview(optionBtn3)
        buttonStack.addArrangedSubview(optionBtn4)
    }
    
    private func setupBtns() {
        optionBtn1.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        optionBtn2.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        optionBtn3.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        optionBtn4.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
    }
}

// MARK: - LifeCycle
extension GameView {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.newGame()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - GameViewProtocol
extension GameView: GameViewProtocol {
    func displayAlert(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func displayPokemonOptions(_ pokemons: [String]) {
        resultLabel.text = ""
        
        optionBtn1.setTitle(pokemons[0].capitalized, for: .normal)
        optionBtn1.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        
        optionBtn2.setTitle(pokemons[1].capitalized, for: .normal)
        optionBtn2.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        
        optionBtn3.setTitle(pokemons[2].capitalized, for: .normal)
        optionBtn3.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        
        optionBtn4.setTitle(pokemons[3].capitalized, for: .normal)
        optionBtn4.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)

        guard let sender = sender else { return }
        
        //sender.addTarget(self, action: #selector(didOptionBtnTapped), for: .touchUpInside)
        sender.backgroundColor = .lightGray
        sender.setTitleColor(.black, for: .normal)
    }
    
    
    func displayShadowImage(url: URL) {
         DispatchQueue.main.async {
             let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
             self.imageView.kf.setImage(
                with: url,
                options: [
                    .processor(effect)
                ]
             )
        }
    }
    
    func displayAnswer(isCorrect: Bool, name: String, url: URL) {
        guard let sender = sender else { return }
        if isCorrect {
            resultLabel.text = "Sí, es un \(name)"
            sender.backgroundColor = UIColor.systemGreen
        } else {
            resultLabel.text = "No, es un \(name)"
            sender.backgroundColor = UIColor.systemRed
            sender.setTitleColor(.white, for: .normal)
            
        }
        
        self.imageView.kf.setImage(with: url)
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
            isCorrect ? self?.presenter?.getNewOptions() : self?.presenter?.showGameOverView()
        }
    }
    
    func displayScore(_ score: Int) {
        scoreLabel.text = "Puntaje: \(score)"
    }

}
