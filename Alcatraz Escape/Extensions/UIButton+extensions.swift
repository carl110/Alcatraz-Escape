//
//  UIButton+extensions.swift
//  Popcorn Swirl
//
//  Created by Carl Wainwright on 03/06/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func centerTextHorizontally(spacing: CGFloat) {
        //adds spacing/padding to the left and right
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        //centers text
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func enableButton() {
        alpha = 1.0
        isEnabled = true
    }
    
    func disableButton() {
        alpha = 0.0
        isEnabled = false
    }
    
    func mainButtonSetup() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = UIColor.Shades.standardGrey
            self?.setTitleColor(UIColor.Shades.standardBlack, for: .normal)
            self?.alpha = 0.75
            self?.titleLabel?.numberOfLines = 2
            self?.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            self?.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self?.frame.height)! / 4)
//            self?.titleLabel?.adjustsFontSizeToFitWidth = true
            self?.centerTextHorizontally(spacing: 2)
            self?.contentVerticalAlignment = .center
            self?.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        }
        
    }
    
}


class SingletonClass {
    
    class var sharedInstance: SingletonClass {
         struct Singleton {
             static let instance = SingletonClass()
         }

         return Singleton.instance
     }
    
    var cornerRoundingNumber: CGFloat = 25
}
