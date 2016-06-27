//
//  ImageChooser.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/26/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import Foundation
import UIKit

class ImageCatcher: UIImageView{
    private var _imagesDictionary: [String: UIImage]?
    private var _currentImageKey: String?
    
    internal var images: [String: UIImage]{
        set{
            _imagesDictionary = newValue
            self.changeRandomImage()
        }
        get{
            if _imagesDictionary != nil{
                return _imagesDictionary!
            }
            return [:]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    //key param will search in the imagesDictionary if is in dictionary will return true and set a new randomImages
    //if not ocurrances in the dictionary will return false
    internal func keyIsCurrent(key: String) -> Bool{
        if _currentImageKey != nil{
            let isCurrentImageKey = key == _currentImageKey
            if isCurrentImageKey{
                changeRandomImage()
            }
            return isCurrentImageKey
        }
        return false
    }
    
    //select one random image from _image dictionary and set it as image
    internal func changeRandomImage(){
        if _imagesDictionary != nil{
            let uIntSize =  UInt32(_imagesDictionary!.count)
            let random =  Int(arc4random_uniform(uIntSize))
            let randomKey = Array(_imagesDictionary!.keys)[random]
            _currentImageKey = randomKey
            self.image = _imagesDictionary![randomKey]
        }
    }
    
}
