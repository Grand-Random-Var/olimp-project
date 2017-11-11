//
//  Button+Animations.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    
    //Функция используется только для разыгрывания комбинации, не для нажатий
    func blink(withColor color: UIColor, animationDucation: TimeInterval = 0.2, completion: @escaping () -> Void = {}) {
        
        self.brighten(withColor: color, animationDucation: animationDucation/2) { (_) in
             self.darken(withColor: defaultTileColor, animationDucation: animationDucation/2) {_ in 
                completion()
            }
        }
        
    }
    
    //Если color == nil, то цвет остается прежним
    private func brighten(withColor color: UIColor, animationDucation: TimeInterval, completion: @escaping (Bool) -> Void = { (_) in }) {
        
        
        UIView.animate(withDuration: animationDucation, delay: 0, options: [.beginFromCurrentState], animations: { 
            self.backgroundColor = color
            self.alpha = 1
        }) { (bool) in
            completion(bool)
        }
        
        
    }
    
    private func darken(withColor color: UIColor, animationDucation: TimeInterval, completion: @escaping (Bool) -> Void = { (_) in }) {
        UIView.animate(withDuration: animationDucation, animations: { 
            
            self.backgroundColor = color
            self.alpha = dimAlphaConstant
//            self.resize(withScale: 1)
            
        }) { (bool) in
            completion(bool)
        }
    }
    
    
    func becomePressed() {
        self.resize(withScale: 0.83, animationDuration: 0.2) { (bool) in
            
        }
    }
    func resignPressed() {
        self.resize(withScale: 1, animationDuration: 0.2) { (bool) in
            
        }
    }
    
    func resize(withScale scale: CGFloat, animationDuration: TimeInterval = 0.2, completion: @escaping (Bool) -> Void = { (_) in }) {
        UIView.animate(withDuration: animationDuration, animations: { 
            
            self.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            
        }) { (bool) in
            
            completion(bool)
        }
    }
    
}
