//
//  UIColor_Extension.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 09.09.2024.
//

import UIKit

extension UIColor {
    // get rgba values of the color
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    // checking whether the color is bright or dark
    var isLight: Bool {
            var white: CGFloat = 0
            getWhite(&white, alpha: nil)
            return white > 0.5
    }
}
