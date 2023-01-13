//
//  OptionButton.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 15/12/22.
//

import UIKit

final class OptionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        setTitleColor(.black, for: .normal)
        backgroundColor = .lightGray
        titleLabel?.font = UIFont(name: "asd", size: 21)
        layer.cornerRadius = 10
    }
}
