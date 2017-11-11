//
//  FarmViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class PlayFieldViewController: UIViewController {
    
    @IBOutlet var tileOutletCollection: [UIButton]!
    
    override func viewDidLoad() {
        
        for tile in self.tileOutletCollection {
            tile.alpha = 0.5
        }
        
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
        
        self.playCombination(numberOfSteps: 5, speed: 0)
        
        
    }
}



