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
    
    let HEX_IMAGE_COUNT = 3
    let HEX_BASE_NAME = "hex"
    let SQUARE_IMAGE_COUNT = 3
    let SQUARE_BASE_NAME = "square"
    let TRIANGLE_IMAGE_COUNT = 3
    let TRIANGLE_BASE_NAME = "triangle"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hexImageView.dropTarget = shapeImageCatcher
        squareImageView.dropTarget = shapeImageCatcher
        triangleImageView.dropTarget = shapeImageCatcher
        
        var imagesDictionary = [String: UIImage]()
        imagesDictionary[SQUARE_BASE_NAME] = UIImage(named: SQUARE_BASE_NAME + "0.png" )
        imagesDictionary[HEX_BASE_NAME] = UIImage(named: HEX_BASE_NAME + "0.png" )
        imagesDictionary[TRIANGLE_BASE_NAME] = UIImage(named: TRIANGLE_BASE_NAME + "0.png" )
        shapeImageCatcher.images = imagesDictionary
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.shapeDropped(_:)),name: DragImage.Events.onTargetDrop, object: nil)
        
        loadAnimationImageView(hexImageView,baseUIImageName: HEX_BASE_NAME,imageCount: HEX_IMAGE_COUNT)
        loadAnimationImageView(squareImageView, baseUIImageName: SQUARE_BASE_NAME, imageCount: SQUARE_IMAGE_COUNT)
        loadAnimationImageView(triangleImageView, baseUIImageName: TRIANGLE_BASE_NAME, imageCount: TRIANGLE_IMAGE_COUNT)
        
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

