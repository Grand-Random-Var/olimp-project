//
//  FarmViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

//let window = (UIApplication.shared.delegate as! AppDelegate).window!

class PlayFieldViewController: UIViewController, StartControllerDelegate {
    
    
    //Outlets
    @IBOutlet var tileButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    //Properties
    var currentScore = 0 {didSet{ scoreLabel.text = "\(currentScore)" }}
    var task: [Int] = []
    var userTask = [Int]()
    
    var timerDelayBeforePlayingCombination: Timer?
    
    //кнопка для старта. туда можно добавить game over и другую информацию
    let startController = startViewController()
    
    //шаги для playCombination
    var maxSteps = 5
    //скорость анимации playCombination
    var speed = 1
    
    var lifeCount = 0 { didSet{
        lifeLabel.text = "\(lifeCount)"
        if lifeCount == 0 { gameOver() }else{
            nextRound()
        }
        }}
    
    //для отслеживания какая по счету плитка угадывается
    var userStep: Int = 0 { didSet{
        if userStep == maxSteps {
            userStep = 0
            inGame = false
            currentScore += 1
            nextRound()
        }
        }}

    //если выполняется playCombination, то inGame = false
    var inGame = false
    
    override func viewDidLoad() {
        
        lifeCount = 3
        
        for tile in self.tileButtons {
            tile.alpha = 0.5
            tile.addTarget(self, action: #selector(self.tileTapped(sender:)), for: .touchUpInside)
        }

        startController.delegate = self
        startController.modalPresentationStyle = .overCurrentContext
        present(startController, animated: false, completion: nil)
        
    }
    
    func startRound() {
        self.timerDelayBeforePlayingCombination?.invalidate()
        
        self.timerDelayBeforePlayingCombination = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self](timer) in
            guard let s = self else { return }
            self?.playCombination(numberOfSteps: s.maxSteps, speed: 1)
        })
    }
    
    @objc private func tileTapped(sender: UIButton) {
        
        guard inGame else { return }
        if task[userStep] == sender.tag {
            print("ПРАВИЛЬНЫЙ ВЫБОР")
            userStep += 1
        }else{
            print("МИНУС ЖИЗНЬ")
            lifeCount -= 1
        }
        
    }
    
    private func playCombination(numberOfSteps: Int, speed: TimeInterval) {
        
        var count = 0
        
        func recursionAnimation() {
            
//            print("first recursion. count = \(count)")
            
            let randomValue = Int(arc4random_uniform(9))
            
            self.task.append(randomValue + 1)
            
            self.tileButtons[randomValue].blink(animationDucation: speed){
                count += 1
                
//                print("before comparing count = \(count)")
                if count < numberOfSteps {
                    recursionAnimation()
                }
            }
        }
        
        recursionAnimation()
        inGame = true
        
    }
    
    
    
    @IBAction func testButtonTapped(_ sender: UIView) {
//        self.playCombination(numberOfSteps: 5, speed: 0)
        present(startController, animated: false, completion: nil)
    }

    private func dimAndStopPlay(withRecord score: Int) {
        
    }
    
    func nextRound() {
        present(startController, animated: false, completion: nil)
    }
    
    func gameOver() {
        print("GAME OVER")
        dataManager.setRecord(currentScore)
        present(startController, animated: false, completion: nil)
    }
        
    
}



