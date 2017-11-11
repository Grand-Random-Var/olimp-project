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
        
        //Устанавливаем массив miners
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setIndicators()
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
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        //Перенёс установку checkmark'a в cellForRowAtIndexPath метод
//        self.tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
        
        //Сохранение последнего используемого майнера
        dataManager.lastUsedMinerIndex = indexPath.row
        
        //Посылаю уведомление о том, что поменял машину. За этим уведомлением будет наболюдать FarmViewController
        NotificationCenter.default.post(name: NSNotification.Name.init("minerChanged"), object: nil)
        
        //Обновлять checkmark буду с помощью простого reloadData
        self.tableView.reloadData()
        
    }
    
    
    //MARK: Custom functions
    
    //Установка и обновление label'ов индикаторов
    private func setIndicators() {
        swiftcoinsCountLabel.text = "свифткоины: \(dataManager.swiftcoins)"
        energyCountLabel.text = "энергия: \(dataManager.energy)"
    }
    
}
