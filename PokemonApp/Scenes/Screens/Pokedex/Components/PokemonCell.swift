//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 23/12/22.
//

import Foundation
import UIKit

final class PokemonCell: UITableViewCell {
    //MARK: - Properties
    static let reuseIdentifier: String = "CELL_ID"
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .boldSystemFont(ofSize: 16)
        element.textColor = .systemYellow
        element.backgroundColor = .systemGray
        return element
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setupCell(pokemon: String) {
        nameLabel.text = pokemon
    }
    
    private func setupLayout() {
        //Name
        contentView.addSubview(nameLabel)
        nameLabel.layout {
            $0.top == contentView.topAnchor
            $0.bottom == contentView.bottomAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
        }
    }
}
