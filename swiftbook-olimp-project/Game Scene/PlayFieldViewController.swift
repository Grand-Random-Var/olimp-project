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
    
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    //Label для разговора с игроком
    @IBOutlet weak var interactiveLabel: UILabel!
    
    
    let dimViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dimViewControllerStoryboardID") as! DimViewController
    
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
    var score: Int = 0
    var life: Int = 3
    //
    var task: [Int] = []
    //Zero-based индекс текущего хода
    var currentStep = 0
//    var isInGame = false
    var timerDelayBeforePlayingCombination: Timer?
    
    override func viewDidLoad() {
        
        
        print("settings: \(dataManager.settings)")
        print("score per win with dur: \(scorePerWin(withSettings: dataManager.settings))")
        
        
        for tile in self.tileButtons {
            tile.alpha = dimAlphaConstant
            tile.setTitle("", for: .normal)
            
            tile.layer.borderColor = UIColor.white.cgColor
            tile.layer.borderWidth = 3
            
            tile.addTarget(self, action: #selector(self.aTileTouchDownInside(sender:)), for: .touchDown)
            tile.addTarget(self, action: #selector(self.aTileTouchUpInside(sender:)), for: .touchUpInside)
            tile.addTarget(self, action: #selector(self.aTileTouchUpOutside(sender:)), for: .touchUpOutside)
        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "firstLaunchPresentDimViewControlletIdentifier", sender: self)
        }
        
        
        self.scoreLabel.text = "0"
        self.lifeLabel.text = "3"
        self.interactiveLabel.text = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc private func aTileTouchDownInside(sender: UIButton) {
//        sender.becomePressed()
    }
    
    @objc private func aTileTouchUpInside(sender: UIButton) {
        //Подтвержденное нажатие
        //В этом случае уже нужно проверять
        
        
        //Если совпало
        print("task before comparing: \(self.task)")
        print("currentStep: \(currentStep)")
        
        if sender.tag == self.task[currentStep] {
            
//            defer {
//                currentStep += 1
//            }
            
            //Если это был последний отгаданный квадратик
            if currentStep == dataManager.settings.numberOfBlinks-1 {
                //Выигрыш раунда!
                sender.highlight(withColor: rightTileTappedColor, animationDuration: blinkAnimationDurationOnTap)
                
                //В данном кейсе прибавлять currentStep не нужно
                
                self.win()
                
            } else {
                //продолжаем смотреть
                sender.highlight(withColor: rightTileTappedColor, animationDuration: blinkAnimationDurationOnTap)
                
                //Так как не последний, то нужно вести счетчик
                currentStep += 1
            }
            
        } else {
            //не совпало
            sender.highlight(withColor: wrongTileTappedColor, animationDuration: blinkAnimationDurationOnTap)
            sender.superview?.superview?.vibrate()
            self.lose()
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
//        self.task = []
        self.gameStatus = .isShowingCombination
        
        var count = 0
        
        func recursionAnimation() {
            
            print("first recursion. count = \(count)")
            
            //диапазон [1;9]
            let randomValue = Int(arc4random_uniform(9)) + 1
            
            self.task.append(randomValue)
            
            self.tileButtons[randomValue-1].highlight(withColor: defaultTileColor, animationDuration: dataManager.settings.blinkDuration) {
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
    
    
    
    @IBAction func reloadButtonTapped(_ sender: UIView) {
        
//        self.win()
        
//        print("settings: \(dataManager.settings)")
        
        self.performSegue(withIdentifier: "reloadPresentDimViewControllerIdentifier", sender: nil)
        
        
        
//        dimAndShowStart()
//        self.gameStatus = .isStopped
        
    }
    
    
    
    
    private func dimAndStopPlay() {
        
    }
    
    
    
    private func dimAndShowStart() {
        
        self.gameStatus = .isShowingCombination
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "presentModallyDimViewControllerIdentifier", sender: self)
            
        }
//        dimView = UIView.init(frame: self.view.frame)
//        dimView.backgroundColor = .black
//        //Потом сильнее проясню цвет
//        dimView.alpha = 0.3
        
//        startButton = UIButton.init()
//        startButton.frame.size = CGSize.init(width: dimView.frame.size.width * 0.74, height: 54)
//        startButton.center = dimView.center
//        startButton.setTitle("Старт!", for: .normal)
//        startButton.titleLabel!.font = startButton.titleLabel!.font.withSize(24)
//        startButton.backgroundColor = #colorLiteral(red: 0.9583352208, green: 0.8847941756, blue: 0.2802580595, alpha: 1)
//        startButton.alpha = 0.3
//        startButton.addTarget(self, action: #selector(self.startButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
//        startButton.clipsToBounds = true
//        startButton.layer.cornerRadius = 8
//        
//        
//        self.view.addSubview(dimView)
//        self.view.addSubview(startButton)
//        
//        
//        
//        UIView.animate(withDuration: 0.2, animations: { 
//            self.dimView.alpha = 0.5
//            self.startButton.alpha = 1.0
//        }) { (bool) in
//            //nothing
//        }
        
        
    }
    
    
//    @objc func startButtonTapped(sender: UIButton) {
//        
//        //Анимация ичезновения dimView
//        UIView.animate(withDuration: 0.2, animations: { 
//            self.startButton.alpha = 0.3
//            self.dimView.alpha = 0.3
//        }) { (bool) in
//            self.startButton.isHidden = true
//            self.dimView.isHidden = true
//        }
//        
//        self.startNewRound()
//    }
    
    
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
    
    
    private func win() {
        
        //косметическая часть
        self.score += scorePerWin(withSettings: dataManager.settings)
        self.scoreLabel.text = "\(self.score)"
        self.scoreLabel.highlightWithScale()
        
        
        //логическая часть
        self.startNewRound()
        
    }
    
    private func lose() {
        
        //Если теряется не последняя жизнь 
        if self.life > 0 {
            self.life -= 1
            self.lifeLabel.text = "\(self.life)"
            self.lifeLabel.highlightWithScale()
            
            self.startNewRound()
            
        } else {
            //Настоящий луз
            self.performSegue(withIdentifier: "gameOverPresentDimViewControllerIdentifier", sender: self)
        }
    }
    
    //Используется при проигрыше или выигрыше
    /*private*/ func startNewRound() {
        
        self.gameStatus = .isStopped
        
        self.task = []
        self.currentStep = 0
        self.interactiveLabel.text = "Запомните комбинацию"
        
        self.timerDelayBeforePlayingCombination?.invalidate()
        self.timerDelayBeforePlayingCombination = Timer.scheduledTimer(withTimeInterval: delayBeforePlayingCombination, repeats: false, block: { (timer) in
            self.playCombination(withSettings: dataManager.settings)
        })
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "firstLaunchPresentDimViewControlletIdentifier":
            let dvc = segue.destination as! DimViewController
            dvc.primeViewController = self
            dvc.context = .firstLaunch
            
        case "gameOverPresentDimViewControllerIdentifier":
            let dvc = segue.destination as! DimViewController
            dvc.primeViewController = self
            dvc.context = DimViewController.Context.gameOver
            
        case "reloadPresentDimViewControllerIdentifier":
            let dvc = segue.destination as! DimViewController
            dvc.primeViewController = self
            dvc.context = DimViewController.Context.reload
        case "tabBarPickedPresentWithoutAnimationIdentifier":
            let dvc = segue.destination as! DimViewController
            dvc.primeViewController = self
            dvc.context = DimViewController.Context.tabBared
            
        default:
            fatalError("промазал")
        }
    }
    
}



