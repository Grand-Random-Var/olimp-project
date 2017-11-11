//
//  MinerTableViewCell.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class MinerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var theImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    //Label показывающий текущий шанс. Говорю "текущий", потому что он сможет увеличиваться с помощью плюшек в магазине
    @IBOutlet weak var farmChanceLabel: UILabel!
    //Label цены. Если майнер куплен, то должна быть приписка "/куплен"
    @IBOutlet weak var priceAndStatusLabel: UILabel!
    
    
    func setup(withMiner miner: Miner) {
        self.theImageView.image = miner.image
        self.nameLabel.text = miner.name
    }
    
}
