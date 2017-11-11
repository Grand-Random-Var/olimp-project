//
//  ViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/7/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class MinersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlet'ы
    @IBOutlet weak var swiftcoinsCountLabel: UILabel!
    @IBOutlet weak var energyCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
//        dataManager = DataManager.shared
        
        //Устанавливаем массив miners
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateIndicators()
    }
    
    //MARK: UITableViewDataSource implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.miners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MinerTableViewCellIdentifier", for: indexPath) as! MinerTableViewCell 
        
        cell.setup(withMiner: dataManager.miners[indexPath.row])
        
        //Обновляю checkmark
        if dataManager.lastUsedMinerIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    //MARK: UITableViewDelegate implementation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Если не куплен...
        if !dataManager.miners[indexPath.row].isBought {
            
            let minerToBuy = dataManager.miners[indexPath.row]
            
            //И если хватает денег, то выскакивет AlertController...
            if dataManager.swiftcoins >= minerToBuy.price {
                //...предлагающий купить майнер
                let ac = UIAlertController.init(title: "Покупка", message: "Купить \(minerToBuy.name) за \(minerToBuy.price) свифткоинов?", preferredStyle: UIAlertControllerStyle.alert)
                ac.addAction(UIAlertAction.init(title: "Отмена", style: UIAlertActionStyle.cancel, handler: {(action) in 
                    //убрать выделение cell'a
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }))
                ac.addAction(UIAlertAction.init(title: "Купить", style: .default, handler: { (action) in
                    
                    
                    //Алгоритм покупки:
                    minerToBuy.isBought = true
                    dataManager.swiftcoins -= minerToBuy.price
                    
                    //выбор купленного майнера
                    dataManager.lastUsedMinerIndex = indexPath.row
                    
                    //Посылаю уведомление о том, что поменял майнер. За этим уведомлением будет наболюдать PlayFieldViewController
                    NotificationCenter.default.post(name: NSNotification.Name.init("minerChanged"), object: nil)
                    
                    //Из-за метода reloadData анимация метода deselectRow может не сработать
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    
                    self.tableView.beginUpdates()
                    self.tableView.reloadData()
                    self.tableView.endUpdates()
                    //и тоже убрать выделение cell'a
                }))
                
                self.present(ac, animated: true, completion: nil)
                
            } else {
                //...а в противном случае сообщающий, что недостаточно денег для покупки
                
                let ac = UIAlertController.init(title: nil, message: "Не хватает свифткоинов для покупки", preferredStyle: .alert)
                ac.addAction(UIAlertAction.init(title: "Пойду майнить!", style: .default, handler: { (action) in 
                    //убрать выделение cell'a
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }))
                
                
                self.present(ac, animated: true, completion: nil)
                
            }
            
            
        } else {
            //в противном случае просто меняем miner'a
            self.tableView.deselectRow(at: indexPath, animated: true)
            
            dataManager.lastUsedMinerIndex = indexPath.row
            
            //Посылаю уведомление о том, что поменял майнер. За этим уведомлением будет наболюдать PlayFieldViewController
            NotificationCenter.default.post(name: NSNotification.Name.init("minerChanged"), object: nil)
            
            
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            self.tableView.endUpdates()
            
        }
        
    }
    
    
    //MARK: Custom functions
    
    //Установка и обновление label'ов индикаторов
    private func updateIndicators() {
        swiftcoinsCountLabel.text = "свифткоины: \(dataManager.swiftcoins)"
        energyCountLabel.text = "энергия: \(dataManager.energy)"
    }
    
}
