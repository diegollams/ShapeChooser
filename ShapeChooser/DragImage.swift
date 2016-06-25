//
//  DragImage.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/24/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView{
    
    private var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    struct Events{
        static let onTargetDrop = "onTargetDrop"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget{
            
            let position = touch.locationInView(getRootView())
            
            if CGRectContainsPoint(target.frame, position){
                let notification = NSNotification(name: Events.onTargetDrop, object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            }
        }
        self.center = originalPosition
    }
    
    private func getRootView() -> UIView{
        var parent = self.superview
        while true{
            if parent?.superview != nil{
                parent = parent?.superview
            }else{
                return parent!
            }
        }
    }
    
}