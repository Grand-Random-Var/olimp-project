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
    
    func blink(animationDucation: TimeInterval = 0.2, completion: @escaping () -> Void) {
        UIView.animate(withDuration: animationDucation/2, animations: { 
            
            self.alpha = 1
            
        }) { (bool) in
            
            UIView.animate(withDuration: animationDucation/2, animations: { 
                self.alpha = dimAlphaConstant
            }, completion: { (bool) in
                
                
                completion()
            })
            
            
        }
    }

    
}
