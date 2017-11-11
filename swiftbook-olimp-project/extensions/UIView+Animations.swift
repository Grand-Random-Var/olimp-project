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
    func highlight(withColor color: UIColor, animationDuration: TimeInterval = 0.2, completion: @escaping () -> Void = {}) {
        
        self.brighten(withColor: color, animationDuration: animationDuration/2) { (_) in
             self.darken(withColor: defaultTileColor, animationDuration: animationDuration/2) {_ in 
                completion()
            }
        }
        
    }
    
    //Если color == nil, то цвет остается прежним
    private func brighten(withColor color: UIColor, animationDuration: TimeInterval, completion: @escaping (Bool) -> Void = { (_) in }) {
        
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.beginFromCurrentState], animations: { 
            self.backgroundColor = color
            self.alpha = 1
        }) { (bool) in
            completion(bool)
        }
        
        
    }
    
    private func darken(withColor color: UIColor, animationDuration: TimeInterval, completion: @escaping (Bool) -> Void = { (_) in }) {
        UIView.animate(withDuration: animationDuration, animations: { 
            
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
    
    func highlightWithScale(_ scale: CGFloat = 1.18) {
        self.resize(withScale: scale, animationDuration: blinkAnimationDurationOnTap/2) { (bool) in
            self.resize(withScale: 1, animationDuration: blinkAnimationDurationOnTap/2, completion: { (bool) in
                //nothing
            })
        }
    }
    
    func vibrate() {
        self.vibrate(times: 3, fullDuration: 0.18, amplitudeX: 5, amplitudeY: 0, startFromRight: true, startFromTop: true)
    }
    
    //TODO: Разберись с количеством колебаний
    
    func vibrate(times: Int,fullDuration: TimeInterval, amplitudeX: CGFloat,amplitudeY: CGFloat,startFromRight: Bool, startFromTop: Bool) {
        let oneMovementTime = fullDuration/(Double(times * 2))
//        m += 1
//        print("oneMovementTime #\(m) = \(oneMovementTime)")
        var rightMovesCount = 0
        var shouldMoveRight = true
        
        func moveSomewhere() {
            
            guard rightMovesCount < times else {
                
                UIView.animate(withDuration: oneMovementTime, delay: 0, options: [], animations: { 
                    self.transform = CGAffineTransform.identity
                }, completion: { (bool) in
                    print("Полное окочание анимации")
                })
                
                return
            }
            
            if shouldMoveRight {
                
                UIView.animate(withDuration: oneMovementTime, delay: 0, options: [], animations: { 
                    self.transform = CGAffineTransform(translationX: startFromRight ? -amplitudeX : amplitudeX, y: startFromTop ? -amplitudeY : amplitudeY)
                }, completion: { (bool) in
                    rightMovesCount += 1
                    shouldMoveRight = !shouldMoveRight
                    moveSomewhere()
                    
                })
                
            } else {
                UIView.animate(withDuration: oneMovementTime, delay: 0, options: [], animations: { 
                    self.transform = CGAffineTransform(translationX: startFromRight ? amplitudeX : -amplitudeX, y: startFromTop ? amplitudeY : -amplitudeY)
                }, completion: { (bool) in
                    shouldMoveRight = !shouldMoveRight
                    moveSomewhere()
                })
            }
            
        }
        
        moveSomewhere()
        
    }
    
}
