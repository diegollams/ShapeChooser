//
//  ViewController.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/23/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var hexImageView: DragImage!
    @IBOutlet var squareImageView: DragImage!
    @IBOutlet var triangleImageView: DragImage!
    @IBOutlet var shapeImageCatcher: ImageCatcher!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: TimerLabel!
    @IBOutlet var heart0: UIImageView!
    @IBOutlet var heart1: UIImageView!
    @IBOutlet var heart2: UIImageView!
    
    let initialLives = 3
    var remainingLives = 0
    let initialScore = 0
    var score = 0
    
    
    
    let HIGH_SCORE_DEFAULT = "high_score"
    let OPAQUE: CGFloat = 1.0
    let DIM_ALPHA: CGFloat = 0.2
    let HEX_IMAGE_COUNT = 3
    let HEX_BASE_NAME = "hex"
    let SQUARE_IMAGE_COUNT = 3
    let SQUARE_BASE_NAME = "square"
    let TRIANGLE_IMAGE_COUNT = 3
    let TRIANGLE_BASE_NAME = "triangle"
    let END_GAME_TITLE = "Ended Game"
    let RESTART_GAME = "Restart"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
        
        //set droptarget the imageCatcher
        hexImageView.dropTarget = shapeImageCatcher
        squareImageView.dropTarget = shapeImageCatcher
        triangleImageView.dropTarget = shapeImageCatcher
        
        let imagesDictionary = [SQUARE_BASE_NAME: UIImage(named: SQUARE_BASE_NAME + "0.png" )!, HEX_BASE_NAME: UIImage(named: HEX_BASE_NAME + "0.png" )!, TRIANGLE_BASE_NAME: UIImage(named: TRIANGLE_BASE_NAME + "0.png" )!]
        shapeImageCatcher.images = imagesDictionary
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.shapeDropped(_:)),name: DragImage.Events.onTargetDrop, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.timerEnded(_:)), name: TimerLabel.Events.onTimerFinish, object: nil)
        
        loadAnimationImageView(hexImageView,baseUIImageName: HEX_BASE_NAME,imageCount: HEX_IMAGE_COUNT)
        loadAnimationImageView(squareImageView, baseUIImageName: SQUARE_BASE_NAME, imageCount: SQUARE_IMAGE_COUNT)
        loadAnimationImageView(triangleImageView, baseUIImageName: TRIANGLE_BASE_NAME, imageCount: TRIANGLE_IMAGE_COUNT)
        
    }
    
    func startGame(){
        remainingLives = initialLives
        score = initialScore
        scoreLabel.text = "\(score)"
        shapeImageCatcher.changeRandomImage()
        heart0.alpha = OPAQUE
        heart1.alpha = OPAQUE
        heart2.alpha = OPAQUE
        timerLabel.startingTime = 5
        timerLabel.startTimer()
    }
    
    func getHighScore() -> Int{
        let defaults = NSUserDefaults.standardUserDefaults()
        let highScore = defaults.integerForKey(HIGH_SCORE_DEFAULT)
        if highScore > score{
            return highScore
        }else{
            defaults.setInteger(score, forKey: HIGH_SCORE_DEFAULT)
            return score
        }
    }
    
    func endGame(){
        timerLabel.stopTimer()
        let endGameAlert = UIAlertController(title: END_GAME_TITLE, message: "Score: \(score)\r\nHigh Score: \(getHighScore())", preferredStyle: UIAlertControllerStyle.Alert)
        endGameAlert.addAction(UIAlertAction(title: RESTART_GAME, style: .Default, handler: {(action: UIAlertAction!) in
           self.startGame()
        }))
        presentViewController(endGameAlert, animated: true, completion: nil)
    }
    
    func substractLife(){
        remainingLives -= 1
        switch remainingLives {
        case 0:
            heart0.alpha = DIM_ALPHA
            endGame()
            break
        case 1:
            heart1.alpha = DIM_ALPHA
            break
        case 2:
            heart2.alpha = DIM_ALPHA
        default:
            break
        }
    }
    
    func timerEnded(notif: NSNotification){
        substractLife()
        timerLabel.restartTimer()
        
    }
    
    func shapeDropped(notif: NSNotification){
        let userInfor = notif.userInfo
        if let view = userInfor!["view"] as! UIView?{
            if view == hexImageView{
                evalShapeDrop(shapeImageCatcher.keyIsCurrent(HEX_BASE_NAME))
            }else if view == squareImageView{
                evalShapeDrop(shapeImageCatcher.keyIsCurrent(SQUARE_BASE_NAME))
            }else if view == triangleImageView{
                evalShapeDrop(shapeImageCatcher.keyIsCurrent(TRIANGLE_BASE_NAME))
            }
        }
        
    }
    
    func evalShapeDrop(dropSuccess: Bool){
        if dropSuccess{
            score += 1
            scoreLabel.text = "\(score)"
            timerLabel.restartTimer()
        }else{
            substractLife()
            timerLabel.restartTimer()
        }
    }
    
    func loadAnimationImageView(imageView: UIImageView, baseUIImageName: String, imageCount: Int){
        var images = [UIImage]()
        for i in 0 ..< imageCount {
            let image = UIImage(named: baseUIImageName +  "\(i)" + ".png")
            //not need of nil check because static images always should exist 
            //this will be test in development
            images.append(image!)
        }
        imageView.animationImages = images
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
    
}

