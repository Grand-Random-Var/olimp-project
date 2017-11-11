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
    @IBOutlet var tileButtons: [UIButton]!
    
    //Label для разговора с игроком
    @IBOutlet weak var interactiveLabel: UILabel!
    
    
    enum GameStatus {
        case isStopped, isShowingCombination,isGuessing
    }
    
    //Properties
    var gameStatus: GameStatus = .isStopped {
        didSet {
            switch self.gameStatus {
            case .isStopped:
                self.disableTiles()
                self.interactiveLabel.text = "Игра окончена"
                break
            case .isShowingCombination:
                self.interactiveLabel.text = "Запомните комбинацию"
                self.disableTiles()
                break 
            case .isGuessing:
                self.interactiveLabel.text = "Повторите комбинацию"
                self.enableTiles()
                
                //test
                print("комбинация: \(self.task)")
                
                break
            }
        }
    }
    var currentScore: Int = 0
    //
    var task: [Int] = []
    //Zero-based индекс текущего хода
    var currentStep = 0
//    var isInGame = false
    var timerDelayBeforePlayingCombination: Timer?
    
    override func viewDidLoad() {
        
        for tile in self.tileButtons {
            tile.alpha = dimAlphaConstant
            tile.setTitle("", for: .normal)
            
            tile.layer.borderColor = UIColor.white.cgColor
            tile.layer.borderWidth = 2
            
            tile.addTarget(self, action: #selector(self.aTileTouchDownInside(sender:)), for: .touchDown)
            tile.addTarget(self, action: #selector(self.aTileTouchUpInside(sender:)), for: .touchUpInside)
            tile.addTarget(self, action: #selector(self.aTileTouchUpOutside(sender:)), for: .touchUpOutside)
        }
        
        self.dimAndShowStart()
        
        self.interactiveLabel.text = ""
        
    }
    
    @objc private func aTileTouchDownInside(sender: UIButton) {
//        sender.becomePressed()
    }
    
    @objc private func aTileTouchUpInside(sender: UIButton) {
        //Подтвержденное нажатие
        //В этом случае уже нужно проверять
        
        
        //Если совпало
        print("task.count: \(task.count)")
        print("currentStep: \(currentStep)")
        if sender.tag == self.task[currentStep] {
            
            defer {
                currentStep += 1
            }
            
            //Если это был последний отгаданный квадратик
            if currentStep == dataManager.settings.numberOfBlinks-1 {
                //Выигрыш раунда!
                sender.blink(withColor: rightTileTappedColor, animationDucation: blinkAnimationDurationOnTap)
                
            } else {
                //продолжаем смотреть
                sender.blink(withColor: rightTileTappedColor, animationDucation: blinkAnimationDurationOnTap)
            }
            
        } else {
            //не совпало
            sender.blink(withColor: wrongTileTappedColor, animationDucation: blinkAnimationDurationOnTap)
        }
        
    }
    @objc private func aTileTouchUpOutside(sender: UIButton) {
//        sender.resignPressed()
    }
    
    private func playCombination(withSettings settings: Settings) {
        self.playCombination(numberOfSteps: settings.numberOfBlinks, blinkDuration: settings.blinkDuration)
    }
    
    private func playCombination(numberOfSteps: Int, blinkDuration: TimeInterval) {
        
        //Обновление даты
        self.task = []
        
        var count = 0
        
        func recursionAnimation() {
            
            print("first recursion. count = \(count)")
            
            //диапазон [1;9]
            let randomValue = Int(arc4random_uniform(9)) + 1
            
            self.task.append(randomValue)
            
            self.tileButtons[randomValue-1].blink(withColor: defaultTileColor) {
                count += 1
                
                print("before comparing count = \(count)")
                if count < numberOfSteps {
                    recursionAnimation()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 500_000_000), execute: { 
                        //Здесь я становлюсь отгадывающим
                        self.gameStatus = .isGuessing
                        
//                        self.prepareForNewRound()
//                        self.currentStep = 0
                    })
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
        
        self.gameStatus = .isStopped
        
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
        
        //Анимация ичезновения dimView
        UIView.animate(withDuration: 0.2, animations: { 
            self.startButton.alpha = 0.3
            self.dimView.alpha = 0.3
        }) { (bool) in
            self.startButton.isHidden = true
            self.dimView.isHidden = true
        }
        
        self.interactiveLabel.text = "Запомните комбинацию"
        
        self.timerDelayBeforePlayingCombination?.invalidate()
        
        self.timerDelayBeforePlayingCombination = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
            self.playCombination(numberOfSteps: 5, blinkDuration: 0.1)
        })
        
    }
    
    
//    private func newRound() {
//        
//    }
    
    //принимает значение tile'a для очередного угадывания
//    private func guess(withTileIndex index: Int) -> Bool {
//        
//        
//        
//        return true
//    }
    
    
    //Используется при проигрыше или выигрыше
    private func prepareForNewRound() {
        self.task = []
        self.currentStep = 0
    }
    
    private func disableTiles() {
        for tile in tileButtons {
            tile.isEnabled = false
        }
    }
    
    private func enableTiles() {
        for tile in tileButtons {
            tile.isEnabled = true
        }
    }
    
    
    
}



