//
//  ViewController.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/23/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var hexImageView: UIImageView!
    @IBOutlet var squareImageView: UIImageView!
    @IBOutlet var triangleImageView: UIImageView!
    @IBOutlet var shapeImageView: UIImageView!
    
    let HEX_IMAGE_COUNT = 3
    let HEX_BASE_NAME = "hex"
    let SQUARE_IMAGE_COUNT = 3
    let SQUARE_BASE_NAME = "square"
    let TRIANGLE_IMAGE_COUNT = 3
    let TRIANGLE_BASE_NAME = "triangle"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAnimationImageView(hexImageView,baseUIImageName: HEX_BASE_NAME,imageCount: HEX_IMAGE_COUNT)
        loadAnimationImageView(squareImageView, baseUIImageName: SQUARE_BASE_NAME, imageCount: SQUARE_IMAGE_COUNT)
        loadAnimationImageView(triangleImageView, baseUIImageName: TRIANGLE_BASE_NAME, imageCount: TRIANGLE_IMAGE_COUNT)
        

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

