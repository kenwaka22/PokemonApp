//
//  GameOverView.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 13/01/23.
//

import UIKit

class GameOverView: UIViewController {
    
    //MARK: Attributes
    var score: Int = 0
    var pokemons = [Pokemon]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: Methods
    
    init(pokemons: [Pokemon], score: Int){
        super.init(nibName: nil, bundle: nil)
        self.score = score
        self.pokemons = pokemons
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStyle(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Perdiste"
        
        scoreLabel.text = "Tu puntaje fue de \(self.score)"
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
    @IBAction func didNewGameBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GameOverView {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupCollectionView()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}

extension GameOverView: UICollectionViewDelegate {
    
}

extension GameOverView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pokemons.count)
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var isCorrect: Bool = true
        if indexPath.row+1 == pokemons.count {
            isCorrect = false
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        
        cell.setupCell(with: pokemons[indexPath.row], isCorrect: isCorrect)
        //cell.backgroundColor = .red
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GameOverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 20) / 2
        let height = 200.0
        return CGSize(width: width, height: height)
    }
}
