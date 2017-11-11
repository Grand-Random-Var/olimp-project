//
//  StartView.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit



class DimViewController: UIViewController {
    
    
    var primeViewController: PlayFieldViewController!
    
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupViews()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.view.alpha = 0
        self.dimView.alpha = 0
        self.startButton.alpha = 0
        
//        UIView.animate(withDuration: 0.3 * 0.3 , animations: { 
////            self.view.alpha = 0.3
//            self.dimView.alpha = 0.3
//            self.startButton.alpha = 0.3
//        }) { (bool) in
//            UIView.animate(withDuration: 0.3 * 0.7, animations: {
//                self.startButton.alpha = 1
//            })
//        }
        UIView.animate(withDuration: 0.3 , animations: { 
            //            self.view.alpha = 0.3
            self.dimView.alpha = 0.3
            self.startButton.alpha = 1
        })
        
        
    }
    
    private func setupViews() {
        //dimView init
        
        //Потом сильнее проясню цвет
        dimView.alpha = 0.3
        startButton.alpha = 0.3

        startButton.addTarget(self, action: #selector(self.startButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        
        startButton.frame.size.width = view.frame.size.width * 0.74
    }
    
    @objc func startButtonTapped(sender: UIView) {
        
        //Анимация исчезновения
        UIView.animate(withDuration: 0.3, animations: { 
            self.dimView.alpha = 0
            self.startButton.alpha = 0
        }) { (bool) in
            self.dismiss(animated: false, completion: nil)
        }
        
        //Начало ногого раунда
        self.primeViewController.startNewRound()
        
    }
    
    deinit {
        print("dim deinitialized")
    }
}
