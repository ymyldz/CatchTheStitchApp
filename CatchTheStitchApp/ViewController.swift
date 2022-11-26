//
//  ViewController.swift
//  CatchTheStitchApp
//
//  Created by Yusuf Mert Yıldız on 26.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var resimArray = [UIImageView]()
    var hiddenTimer = Timer()
    var highscore = 0
    
    @IBOutlet weak var resim1: UIImageView!
    
    @IBOutlet weak var resim2: UIImageView!
    
    @IBOutlet weak var resim3: UIImageView!
    
    @IBOutlet weak var resim4: UIImageView!
    
    @IBOutlet weak var resim5: UIImageView!
    
    @IBOutlet weak var resim6: UIImageView!
    
    @IBOutlet weak var resim7: UIImageView!
    
    @IBOutlet weak var resim8: UIImageView!
    
    @IBOutlet weak var resim9: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highscore = 0
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highScoreLabel.text = "Highscore: \(newScore)"
        }
        
        
        
        
        resim1.isUserInteractionEnabled = true
        resim2.isUserInteractionEnabled = true
        resim3.isUserInteractionEnabled = true
        resim4.isUserInteractionEnabled = true
        resim5.isUserInteractionEnabled = true
        resim6.isUserInteractionEnabled = true
        resim7.isUserInteractionEnabled = true
        resim8.isUserInteractionEnabled = true
        resim9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        resim1.addGestureRecognizer(gestureRecognizer1)
        resim2.addGestureRecognizer(gestureRecognizer2)
        resim3.addGestureRecognizer(gestureRecognizer3)
        resim4.addGestureRecognizer(gestureRecognizer4)
        resim5.addGestureRecognizer(gestureRecognizer5)
        resim6.addGestureRecognizer(gestureRecognizer6)
        resim7.addGestureRecognizer(gestureRecognizer7)
        resim8.addGestureRecognizer(gestureRecognizer8)
        resim9.addGestureRecognizer(gestureRecognizer9)
        
       resimArray = [resim1,resim2,resim3,resim4,resim5,resim6,resim7,resim8,resim9]
        
        
        counter = 5
        timerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideResim()
        hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideResim), userInfo: nil, repeats: true)
        
    }
    @objc func hideResim(){
        
        
        for resim in resimArray{
            resim.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(resimArray.count - 1)))
        resimArray[random].isHidden = false
        }
    
    
    
    
    
    @objc func countDown(){
        counter -= 1
        timerLabel.text = "\(counter)"
        
        if self.score > self.highscore {
            self.highscore = self.score
            highScoreLabel.text = "Highscore : \(highscore)"
            UserDefaults.standard.set(self.highscore, forKey: "highscore")
            
        }
        
        
        if counter == 0{
            for resim in resimArray{
                resim.isHidden = true
            }
            timer.invalidate()
            hiddenTimer.invalidate()
            
            let alert = UIAlertController(title: "Time's Out", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 5
                self.timerLabel.text = "\(self.counter)"
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideResim), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
        }
        
        
        
    }
    
    
    
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score:\(score)"
        
    }


}

