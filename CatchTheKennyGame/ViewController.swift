//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Atil Samancioglu on 13.07.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var highScore = 0
    var counter = 0
    var kennyArray = [UIImageView]()
    var timer = Timer()
    var hideTimer = Timer()
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //highscore check
        let storedScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        if let newScore = storedScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        // imageView kullanıcı etkilişimini aktif etme
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        // dokunma özeliğini çalıştırma
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //imageview e ekleme işlemi
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        //Timers
        timeLabel.text = String(counter)
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
        for kenny in kennyArray{
            kenny.isUserInteractionEnabled = true
        }
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        for kenny in kennyArray{
            kenny.isUserInteractionEnabled = false
        }
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = String(counter)
            for kenny in kennyArray{
                kenny.isHidden = true
            }
           
            //highScore
            if score > highScore{
                highScore = score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to again?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in
            }
            let replayButton = UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
}
