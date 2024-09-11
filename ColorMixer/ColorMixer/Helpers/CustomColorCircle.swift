//
//  CustomColorCircle.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 09.09.2024.
//

import UIKit


class CustomColorCircle: UIView {
    
    // MARK: - Views
    private let colorView = UIView()
    private let colorLabel = UILabel()
    let colorButton = UIButton(type: .system)
    
    // MARK: - Properties
    var width: CGFloat = 200
    var buttonTitle: String? {
        didSet {
            colorButton.setTitle(buttonTitle, for: .normal)
        }
    }
    var color: UIColor? {
        didSet {
            colorView.backgroundColor = color
            
            if let color = color {
                updateTextColor(for: color)
            }
        }
    }
    var colorName: String? {
        didSet {
            colorLabel.text = colorName
        }
    }
    
    // MARK: - Initializers
    init(width: CGFloat, duration:CGFloat, buttonTitle: String?, color: UIColor?){
        super.init(frame: .zero)
        self.width = width
        self.color = color
        self.buttonTitle = buttonTitle
        setupLayOut()
        setConstraints()
        startPulsation(duration: duration) // Start pulsation when view is initialized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Pulsation Effect
    func startPulsation(duration: CGFloat) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = duration  // Start at normal size
        pulseAnimation.toValue = 1.1    // Scale to 10% larger
        pulseAnimation.autoreverses = true  // Reverse the animation (shrink back to normal)
        pulseAnimation.repeatCount = Float.infinity  // Infinite repetition
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
        // Add the animation to the colorView's layer
        colorView.layer.add(pulseAnimation, forKey: "pulsation")
    }
}
    
// MARK: - Set Views
private extension CustomColorCircle {
    func setupLayOut(){
        self.backgroundColor = .clear
        self.addSubview(colorView)
        colorView.addSubview(colorLabel)
        colorView.addSubview(colorButton)
        setColorView()
        setColorLabel()
        setColorButton()
    }
    
    func setColorView(){
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = width / 2
        colorView.isUserInteractionEnabled = true
        
    }
    
    func setColorLabel(){
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.numberOfLines = 0
        colorLabel.textAlignment = .center
        colorLabel.font = .systemFont(ofSize: K.colorLabelFontSize)
        colorLabel.text = color?.accessibilityName ?? "Secret"
        
        if let color = color {
            updateTextColor(for: color)
        }
    }
    
    func setColorButton(){
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.layer.cornerRadius = width / 2
        colorButton.backgroundColor = .clear
        colorButton.tintColor = .clear
        colorButton.setTitle(buttonTitle, for: .normal)
        
    }
    
    func updateTextColor(for color: UIColor){
        colorLabel.textColor = color.isLight ? .black : .white
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: width),
            colorView.heightAnchor.constraint(equalToConstant: width),
            colorLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            colorLabel.leftAnchor.constraint(equalTo: colorView.leftAnchor, constant: 35),
            colorLabel.rightAnchor.constraint(equalTo: colorView.rightAnchor, constant: -35),
            colorButton.widthAnchor.constraint(equalToConstant: width),
            colorButton.heightAnchor.constraint(equalToConstant: width)
        ])
    }
}

    
    
