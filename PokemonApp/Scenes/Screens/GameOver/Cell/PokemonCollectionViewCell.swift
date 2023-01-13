//
//  PokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 13/01/23.
//

import UIKit
import Kingfisher

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak var border: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with pokemon: Pokemon, isCorrect: Bool) {
        if isCorrect {
            border.backgroundColor = UIColor.systemGreen
        } else {
            border.backgroundColor = UIColor.systemRed
        }
        border.layer.cornerRadius = 15
        
        imageView.kf.setImage(with: pokemon.imageUrl)
    }

}
