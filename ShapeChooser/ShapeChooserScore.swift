//
//  ShapeChooserGame.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/28/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import Foundation

class ShapeChooserScore{
    
    private let initialLives = 3
    private var _remainingLives: Int?
    private let initialScore = 0
    private var _score: Int?
    
    var score: Int{
        get{
            if let currentScore = _score{
                return currentScore
            }
            return 0
        }
    }
    var remainingLives: Int{
        get{
            if let lives = _remainingLives{
                return lives
            }
            return 0
        }
    }
    
    init(){

    }
    
    func startGame() {
        self._remainingLives = initialLives
        self._score = initialScore

    }
    
    func restartGame(){
        startGame()
    }
    
    func substractLife() -> Int{
        if _remainingLives != nil{
            _remainingLives! -= 1
        }else{
            _remainingLives = 0
        }
        return _remainingLives!
    }
    
    func addToScore() -> Int{
        if _score != nil{
            _score! += 1
        }else{
            _score = 1
        }
        return _score!
    }
    
}
