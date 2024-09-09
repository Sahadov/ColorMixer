//
//  UIView_Extension.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 09.09.2024.
//

import UIKit

extension UIView {
    
    static func makeCircle(color: UIColor) -> UIView {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = color
        element.layer.cornerRadius = 100
        element.isUserInteractionEnabled = true
        return element
    }
}

