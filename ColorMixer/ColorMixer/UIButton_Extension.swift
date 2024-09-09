//
//  UIButton_Extension.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 09.09.2024.
//

import UIKit

extension UIButton {
    
    static func makeRoundTransparentButton(title: String) -> UIButton {
        let element = UIButton(type: .system)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 100
        element.backgroundColor = .clear
        element.tintColor = .clear
        element.setTitle(title, for: .normal)
        return element
    }
}
