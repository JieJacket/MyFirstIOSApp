//
//  Meal.swift
//  MyFirstIOSApp
//
//  Created by jie on 2016/11/9.
//  Copyright © 2016年 jie. All rights reserved.
//

import UIKit

class Meal{
    var name:String
    var photo:UIImage?
    var rating:Int
    
    init?(name:String,photo:UIImage?,rating:Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        if "" == name || rating < 0 {
            return nil
        }
    }

}
