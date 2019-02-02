//
//  DetailViewController.swift
//  TestGame
//
//  Created by Devtest on 31/01/19.
//  Copyright © 2019 Devtest. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var itemButton: UIBarButtonItem!
    @IBAction func targetButtonTapped(_ sender: Any) {
        print("Target button tapped")
        
        score += 1
        
        UIView.animate(withDuration: 0.25, animations: {self.updateButton()})
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        gameRunning = true
        
    }
    
    var gameRunning: Bool = false {
        didSet {
            itemButton.title = gameRunning ? "Stop" : "Start"
            
            targetButton.isHidden = !gameRunning
            
            configureTimer()
        }
    }
    
    var gameTimer: Timer?
    
    func updateButton() {
        let randomWidth = CGFloat.random(in: 20 ... 100)
        let randomHeight = CGFloat.random(in: 20 ... 100  )
        
        let randomX = CGFloat.random(in: 0 ... view.frame.width - randomWidth)
        let randomY = CGFloat.random(in: view.safeAreaInsets.top ... view.frame.height - randomHeight)
        
        targetButton.frame = CGRect(x: randomX, y: randomY, width: randomWidth, height: randomHeight)
    }
    
    func configureTimer() {
        if gameRunning {
            secondsLeft = 10
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        } else {
            gameTimer?.invalidate()
        }
        
    }
    
    @objc
    func timerFired() {
       print("Timer fired")
        
        secondsLeft -= 1
        if secondsLeft == 0 {
            gameRunning = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameRunning = false
    }
    
    var secondsLeft: TimeInterval = 0 {
        didSet {
            updateTimerLabel()
        }
    }
    var score: Int = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    
    private func updateTimerLabel() {
        timeLabel.text = "Time \(secondsLeft) seconds"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text =
         "Score \(score)"
    }
}

