//
//  ViewController.swift
//  ColorMixer
//
//  Created by Дмитрий Волков on 08.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let topColor = UIView()
    private let bottomColor = UIView()
    private let plusLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }


}

private extension ViewController {
    func setupLayout(){
        view.backgroundColor = .white
        setTopColor()
        setBottomColor()
        setPlusLabel()
    }
    func setTopColor(){
        view.addSubview(topColor)
        topColor.translatesAutoresizingMaskIntoConstraints = false
        topColor.backgroundColor = .black
        topColor.layer.cornerRadius = 100
        
        NSLayoutConstraint.activate([
            topColor.widthAnchor.constraint(equalToConstant: 200),
            topColor.heightAnchor.constraint(equalToConstant: 200),
            topColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topColor.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
    func setBottomColor(){
        view.addSubview(bottomColor)
        bottomColor.translatesAutoresizingMaskIntoConstraints = false
        bottomColor.backgroundColor = .red
        bottomColor.layer.cornerRadius = 100
        
        NSLayoutConstraint.activate([
            bottomColor.widthAnchor.constraint(equalToConstant: 200),
            bottomColor.heightAnchor.constraint(equalToConstant: 200),
            bottomColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomColor.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
    }
    func setPlusLabel(){
        view.addSubview(plusLabel)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.text = "+"
        plusLabel.textColor = .black
        plusLabel.font = .systemFont(ofSize: 40)
        
        NSLayoutConstraint.activate([
            plusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
