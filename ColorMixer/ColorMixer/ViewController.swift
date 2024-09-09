//
//  ViewController.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 08.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let topColorView = UIView.makeCircle(color: .black)
    private let topColorButton = UIButton.makeRoundTransparentButton(title: "topColor")
    private let bottomColorView = UIView.makeCircle(color: .red)
    private let bottomColorButton = UIButton.makeRoundTransparentButton(title: "bottomColor")
    private let plusLabel = UILabel()
    
    var selectedButtonTitle: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupLayout()
        setupConstraints()
    }
}

private extension ViewController {
    func setViews(){
        [topColorView,
         bottomColorView,
         plusLabel
        ].forEach { view.addSubview($0) }
        
        topColorView.addSubview(topColorButton)
        bottomColorView.addSubview(bottomColorButton)
    }
    
    func setupLayout(){
        view.backgroundColor = .white
        setColorViews()
        setPlusLabel()
    }
    
    func setColorViews(){
        topColorButton.addTarget(self, action: #selector(topColorButtonTapped), for: .touchUpInside)
        bottomColorButton.addTarget(self, action: #selector(topColorButtonTapped), for: .touchUpInside)
    }
    func setPlusLabel(){
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.text = "+"
        plusLabel.textColor = .black
        plusLabel.font = .systemFont(ofSize: 40)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topColorView.widthAnchor.constraint(equalToConstant: 200),
            topColorView.heightAnchor.constraint(equalToConstant: 200),
            topColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            topColorButton.centerXAnchor.constraint(equalTo: topColorView.centerXAnchor),
            topColorButton.centerYAnchor.constraint(equalTo: topColorView.centerYAnchor),
            topColorButton.widthAnchor.constraint(equalToConstant: 200),
            topColorButton.heightAnchor.constraint(equalToConstant: 200),
            
            bottomColorView.widthAnchor.constraint(equalToConstant: 200),
            bottomColorView.heightAnchor.constraint(equalToConstant: 200),
            bottomColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            bottomColorButton.centerXAnchor.constraint(equalTo: bottomColorView.centerXAnchor),
            bottomColorButton.centerYAnchor.constraint(equalTo: bottomColorView.centerYAnchor),
            bottomColorButton.widthAnchor.constraint(equalToConstant: 200),
            bottomColorButton.heightAnchor.constraint(equalToConstant: 200),
            
            plusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    @objc func topColorButtonTapped(_ sender: UIButton){
        selectedButtonTitle = sender.currentTitle
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        
        if selectedButtonTitle == "topColor" {
            topColorView.backgroundColor = viewController.selectedColor
        } else {
            bottomColorView.backgroundColor = viewController.selectedColor
        }
    }
}
