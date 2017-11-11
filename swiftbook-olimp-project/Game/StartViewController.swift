//
//  StartView.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

protocol StartControllerDelegate {
    func startRound()
}

class startViewController: UIViewController {

    var delegate: StartControllerDelegate!
    let startButton = UIButton()
    let backgrounView = UIView()
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        
        backgrounView.backgroundColor = .black
        
        //Потом сильнее проясню цвет
        backgrounView.alpha = 0.3

        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel!.font = startButton.titleLabel!.font.withSize(24)
        startButton.backgroundColor = #colorLiteral(red: 0.9583352208, green: 0.8847941756, blue: 0.2802580595, alpha: 1)
        startButton.alpha = 1 //0.3
        startButton.addTarget(self, action: #selector(startButtonAction), for: UIControlEvents.touchUpInside)
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 8
        
        backgrounView.frame = view.frame
        view.addSubview(backgrounView)
        
        view.addSubview(startButton)
        
        setupConstraints()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgrounView.alpha = 0.5
            self.startButton.alpha = 1.0
        }) { (bool) in
            //nothing
        }
    }
    
    func setupConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    @objc func startButtonAction() {
        dismiss(animated: false, completion: nil)
        delegate.startRound()
    }
    
}
