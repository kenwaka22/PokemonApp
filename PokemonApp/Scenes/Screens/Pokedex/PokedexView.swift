//
//  PokedexView.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import UIKit

protocol PokedexViewProtocol: AnyObject {
    var presenter: PokedexPresenterProtocol? { get set }
    func update(with pokemons: [PokemonResult])
    func update(with error: String)
}

//MARK: - Properties
class PokedexView: UIViewController {
    
    var presenter: PokedexPresenterProtocol?
    var pokemons: [PokemonResult] = []
    
    private let tableView: UITableView = {
        let element = UITableView()
        element.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

//MARK: - LifeCycle
extension PokedexView {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.layout {
            $0.top == view.safeAreaLayoutGuide.topAnchor
            $0.bottom == view.safeAreaLayoutGuide.bottomAnchor
            $0.trailing == view.trailingAnchor
            $0.leading == view.leadingAnchor

        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
}

//MARK: - Delegate
extension PokedexView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(pokemons[indexPath.row].name?.capitalized ?? "")"
        return cell
    }

}

//MARK: - Protocol
extension PokedexView: PokedexViewProtocol {
    func update(with pokemons: [PokemonResult]) {
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
