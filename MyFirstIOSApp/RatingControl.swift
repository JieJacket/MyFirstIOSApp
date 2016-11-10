//
//  File.swift
//  MyFirstIOSApp
//
//  Created by jie on 2016/11/9.
//  Copyright © 2016年 jie. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }

    var ratingButtons = [UIButton]()
    var stars = 5
    let spacing = 5
    var isEnable = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in 0..<stars {
            let button = UIButton()
            let emptyImage = UIImage(named: "emptyStar")
            let filledImage = UIImage(named: "filledStar")
            button.setImage(emptyImage, for: .normal)
            button.setImage(filledImage, for: .selected)
            button.setImage(filledImage, for: [.selected,.highlighted])
            
            ratingButtons.append(button)
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            addSubview(button)
        }
    }
    
    func ratingButtonTapped(button:UIButton) {
        if isEnable {
            rating = ratingButtons.index(of: button)! + 1
            updateRatingButtonState()
        }

    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index,button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateRatingButtonState()
    }
    func updateRatingButtonState() {
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
}
