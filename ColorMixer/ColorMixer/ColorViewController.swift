//
//  ViewController.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 08.09.2024.
//

import UIKit

class ColorViewController: UIViewController {
    
    private let topColorView = CustomColorCircle(width: K.topCircleWidth, duration: 1.0, buttonTitle: "topColor", color: .blue)
    private let bottomColorView = CustomColorCircle(width: K.bottomCircleWidth, duration: 1.15, buttonTitle: "bottomColor", color: .green)
    private let leftColorView = CustomColorCircle(width: K.leftCircleWidth, duration: 1.0, buttonTitle: "leftColor", color: .clear)
    private let rightColorView = CustomColorCircle(width: K.rightCircleWidth, duration: 1.2, buttonTitle: "rightColor", color: .clear)
    
    private let resultLabel = UILabel()
    private let plusButton = UIButton(type: .system)
    private let minusButton = UIButton(type: .system)
    private let mixButton = UIButton(type: .system)
    
    var selectedButtonTitle: String?
    var colorsArray = [UIColor]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupLayout()
        setupConstraints()
    }
}

private extension ColorViewController {
    func setViews(){
        [topColorView,
         bottomColorView,
         leftColorView,
         rightColorView,
         plusButton,
         minusButton,
         mixButton,
         resultLabel
        ].forEach { view.addSubview($0) }
    }
    
    func setupLayout(){
        view.backgroundColor = .white
        setColorViews()
        setPlusButton()
        setMixButton()
        setMinusButton()
        setResultLabel()
    }
    
    func setColorViews(){
        topColorView.translatesAutoresizingMaskIntoConstraints = false
        bottomColorView.translatesAutoresizingMaskIntoConstraints = false
        leftColorView.translatesAutoresizingMaskIntoConstraints = false
        rightColorView.translatesAutoresizingMaskIntoConstraints = false
        
        leftColorView.isHidden = true
        rightColorView.isHidden = true
        
        topColorView.colorButton.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
        bottomColorView.colorButton.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
        leftColorView.colorButton.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
        rightColorView.colorButton.addTarget(self, action: #selector(colorTapped), for: .touchUpInside)
    }
    
    func setPlusButton(){
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.tintColor = .black
        plusButton.titleLabel?.font =  .systemFont(ofSize: 30)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
    }
    
    func setMinusButton(){
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.tintColor = .black
        minusButton.titleLabel?.font =  .systemFont(ofSize: 30)
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
    }
    
    func setMixButton(){
        mixButton.translatesAutoresizingMaskIntoConstraints = false
        mixButton.tintColor = .black
        mixButton.titleLabel?.font =  .systemFont(ofSize: 30)
        mixButton.setImage(UIImage(systemName: "paintbrush.pointed"), for: .normal)
        mixButton.addTarget(self, action: #selector(mixColors), for: .touchUpInside)
    }
    
    func setResultLabel(){
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 20)
        resultLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topColorView.widthAnchor.constraint(equalToConstant: K.topCircleWidth),
            topColorView.heightAnchor.constraint(equalToConstant: K.topCircleWidth),
            topColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            topColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            bottomColorView.widthAnchor.constraint(equalToConstant: K.bottomCircleWidth),
            bottomColorView.heightAnchor.constraint(equalToConstant: K.bottomCircleWidth),
            bottomColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -145),
            
            leftColorView.widthAnchor.constraint(equalToConstant: K.leftCircleWidth),
            leftColorView.heightAnchor.constraint(equalToConstant: K.leftCircleWidth),
            leftColorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -50),
            leftColorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            rightColorView.widthAnchor.constraint(equalToConstant: K.rightCircleWidth),
            rightColorView.heightAnchor.constraint(equalToConstant: K.rightCircleWidth),
            rightColorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            rightColorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 45),
            
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            mixButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mixButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            minusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            minusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 35),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            resultLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
    
        ])
        
    }
    
    @objc func colorTapped(_ sender: UIButton){
        selectedButtonTitle = sender.currentTitle
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @objc func plusTapped(){
        if leftColorView.isHidden {
            leftColorView.color = .cyan
            leftColorView.colorName = leftColorView.color?.accessibilityName ?? "Secret"
            fadeInView(leftColorView)
            fadeInView(minusButton)
            //minusButton.isHidden = false
            return
        }
        if rightColorView.isHidden {
            rightColorView.color = .yellow
            rightColorView.colorName = rightColorView.color?.accessibilityName ?? "Secret"
            fadeInView(rightColorView)
            fadeOutView(plusButton)
        }
    }
    
    @objc func minusTapped(){
        if !rightColorView.isHidden {
            fadeOutView(rightColorView)
            rightColorView.backgroundColor = .clear
            fadeInView(plusButton)
            return
        }
        if !leftColorView.isHidden {
            fadeOutView(leftColorView)
            leftColorView.backgroundColor = .clear
            fadeOutView(minusButton)
        }
    }
    
    @objc func mixColors() {
        let colors = getColors()
        let resultedColor = blend(for: colors)
        updateColorUI(resultedColor)
    }
    
    func getColors() -> [UIColor] {
        colorsArray = [topColorView.color!, bottomColorView.color!]
        if !leftColorView.isHidden {
            colorsArray.append(leftColorView.color!)
        }
        if !rightColorView.isHidden {
            colorsArray.append(rightColorView.color!)
        }
        return colorsArray
    }
    
    func updateResultLabelColor(_ color: UIColor){
        if color.isLight {
            resultLabel.textColor = UIColor.black
        } else {
            resultLabel.textColor = UIColor.white
        }
    }
    
    func updateResultLabelText(){
        let colorName = view.backgroundColor?.accessibilityName ?? "secret"
        resultLabel.text = "✨ YOU CREATED \(colorName.uppercased()) COLOR"
    }
    
    func updateButtonsColors(_ color: UIColor){
        if color.isLight {
            plusButton.tintColor = .black
            minusButton.tintColor = .black
            mixButton.tintColor = .black
        } else {
            plusButton.tintColor = .white
            minusButton.tintColor = .white
            mixButton.tintColor = .white
        }
    }
    
    func updateColorUI(_ color: UIColor){
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = color
        }
        //view.backgroundColor = color
        updateResultLabelText()
        updateButtonsColors(color)
        updateResultLabelColor(color)
        
    }
    
    func blend(for colors: [UIColor]) -> UIColor {
        let numberOfColors = CGFloat(colors.count)
        var (red, green, blue, alpha) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

        let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat())) { temp, color in
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return (temp.red+red, temp.green + green, temp.blue + blue, temp.alpha+alpha)
        }
        return UIColor(red: componentsSum.red / numberOfColors,
                           green: componentsSum.green / numberOfColors,
                           blue: componentsSum.blue / numberOfColors,
                           alpha: componentsSum.alpha / numberOfColors)
    }
    
    func fadeOutView(_ view: UIView, duration: TimeInterval = 0.6) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.isHidden = true
        })
    }
    
    func fadeInView(_ view: UIView, duration: TimeInterval = 0.6) {
        view.isHidden = false
        view.alpha = 0  // Set initial alpha to 0 before animating

        UIView.animate(withDuration: duration) {
            view.alpha = 1
        }
    }
}

extension ColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        switch selectedButtonTitle {
        case "topColor":
            topColorView.color = viewController.selectedColor
            topColorView.colorName = topColorView.color?.accessibilityName ?? "Secret"
        case "bottomColor":
            bottomColorView.color = viewController.selectedColor
            bottomColorView.colorName = bottomColorView.color?.accessibilityName ?? "Secret"
        case "rightColor":
            rightColorView.color = viewController.selectedColor
            rightColorView.colorName = rightColorView.color?.accessibilityName ?? "Secret"
        default:
            leftColorView.color = viewController.selectedColor
            leftColorView.colorName = leftColorView.color?.accessibilityName ?? "Secret"
        }
        
        //colorsArray = [topColorView.color!, bottomColorView.color!, leftColorView.color!, rightColorView.color!]
    }
}
