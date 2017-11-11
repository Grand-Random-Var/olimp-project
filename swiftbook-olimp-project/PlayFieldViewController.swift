//
//  FarmViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

//let window = (UIApplication.shared.delegate as! AppDelegate).window!

class PlayFieldViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet var tileOutletCollection: [UIButton]!
    
    //Properties
    var currentScore: Int = 0
    var task: [Int] = []
    
    var timerDelayBeforePlayingCombination: Timer?
    
    override func viewDidLoad() {
        
        for tile in self.tileOutletCollection {
            tile.alpha = 0.5
        }
        
//        self.dimAndShowStart()
        
    }
    
    
    
    private func playCombination(numberOfSteps: Int, speed: TimeInterval) {
        
        var count = 0
        
        func recursionAnimation() {
            
            print("first recursion. count = \(count)")
            self.tileOutletCollection[Int(arc4random_uniform(9))].blink {
                count += 1
                
                print("before comparing count = \(count)")
                if count < numberOfSteps {
                    recursionAnimation()
                }
            }
        }
        
        recursionAnimation()
        
        
    }
    @IBAction func testButtonTapped(_ sender: UIView) {
        
//        self.playCombination(numberOfSteps: 5, speed: 0)
        dimAndShowStart()
        
        
    }
    
    private func dimAndStopPlay(withRecord score: Int) {
        
    }
    
    
    private var dimView: UIView!
    private var startButton: UIButton!
    
    private func dimAndShowStart() {
        
        dimView = UIView.init(frame: self.view.frame)
        dimView.backgroundColor = .black
        //Потом сильнее проясню цвет
        dimView.alpha = 0.3
        
        startButton = UIButton.init()
        startButton.frame.size = CGSize.init(width: dimView.frame.size.width * 0.74, height: 54)
        startButton.center = dimView.center
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel!.font = startButton.titleLabel!.font.withSize(24)
        startButton.backgroundColor = #colorLiteral(red: 0.9583352208, green: 0.8847941756, blue: 0.2802580595, alpha: 1)
        startButton.alpha = 0.3
        startButton.addTarget(self, action: #selector(self.startButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 8
        
        
        self.view.addSubview(dimView)
        self.view.addSubview(startButton)
        
        
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.dimView.alpha = 0.5
            self.startButton.alpha = 1.0
        }) { (bool) in
            //nothing
        }
        
        
    }
    
    
    @objc func startButtonTapped(sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.startButton.alpha = 0.3
            self.dimView.alpha = 0.3
        }) { (bool) in
            self.startButton.isHidden = true
            self.dimView.isHidden = true
        }
        
        self.timerDelayBeforePlayingCombination?.invalidate()
        
        self.timerDelayBeforePlayingCombination = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
            self.playCombination(numberOfSteps: 5, speed: 0.1)
        })
        
    }
    
    
}



