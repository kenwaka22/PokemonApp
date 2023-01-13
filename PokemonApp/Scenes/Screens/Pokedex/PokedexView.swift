//
//  PokedexView.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import UIKit

//MARK: - Protocol
protocol PokedexViewProtocol: AnyObject {
    var presenter: PokedexPresenterProtocol? { get set }
    func update(with pokemons: [Pokemon])
    func update(with error: String)
}

//MARK: - Properties
class PokedexView: UIViewController {
    
    var presenter: PokedexPresenterProtocol?
    var pokemons: [Pokemon] = []
    var pokemonCellUsed = false
    
    private lazy var tableView: UITableView = {
        let element = UITableView()
        if pokemonCellUsed {
            element.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
        } else {
            element.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let label: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.isHidden = true
        return element
    }()
}

// MARK: - Methods
extension PokedexView {
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupLayout(){
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.layout {
            $0.top == view.safeAreaLayoutGuide.topAnchor
            $0.bottom == view.safeAreaLayoutGuide.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.leading == view.leadingAnchor

        }
    }
    
    func setupStyle() {
        title = "Pokedex"
    }
}

//MARK: - LifeCycle
extension PokedexView {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupStyle()
        setTableViewDelegates()
        presenter?.viewDidLoad()
        print("viewDidLoad Pokedex")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
}

//MARK: - DataSource
extension PokedexView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pokemonCellUsed {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell else { fatalError("Unable to dequeue PokemonCell") }
            //cell.setupCell(pokemon: pokemons[indexPath.row].name?.capitalized ?? "")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //cell.textLabel?.text = "\(indexPath.row + 1). \(pokemons[indexPath.row].name?.capitalized ?? "")"
            return cell
        }
    }

}

//MARK: - Delegate
extension PokedexView: UITableViewDelegate {
    
}

//MARK: - ViewProtocol
extension PokedexView: PokedexViewProtocol {
    func update(with pokemons: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemons = pokemons
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.label.isHidden = false
            self.label.text = error
        }
    }
}
