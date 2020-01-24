//
//  UILabels+extensions.swift
//  Maths Genius
//
//  Created by Carl Wainwright on 11/08/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func titleLabelSetUp() {
        self.textColor = UIColor.Shades.standardWhite
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.font = self.font.bold()
    }
    
    func subTitleLabelSetUp() {
        self.textColor = UIColor.Shades.standardWhite
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func bodyLabelSetUp() {
        self.textColor = UIColor.Shades.standardWhite
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
//    func exampleLabelSetUp() {
//            self.backgroundColor = UIColor.Yellows.gryffindorYellow
//            self.textColor = UIColor.Reds.gryffindorRed
//            self.layer.cornerRadius = SingletonClass.sharedInstance.cornerRoundingNumber
//        self.textAlignment = .left
//        self.numberOfLines = 0
//        self.lineBreakMode = .byWordWrapping
//        self.font.withSize(10)
//
//    }
    
    
//    func numberLabelSetup() {
//        DispatchQueue.main.async { [weak self] in
//            self?.backgroundColor = UIColor.Reds.gryffindorRed
//            self?.textColor = UIColor.Yellows.gryffindorYellow
//            //roundedcorners
//            self?.layer.cornerRadius = SingletonClass.sharedInstance.cornerRoundingNumber
//            self?.layer.masksToBounds = true
//            self?.font = .boldSystemFont(ofSize: (self?.frame.height)!)
//            self?.textAlignment = .center
//            self?.numberOfLines = 0
//        }
//
//    }
//    
//    func mySumLabelSetup() {
//            DispatchQueue.main.async { [weak self] in
//                self?.backgroundColor = UIColor.Reds.gryffindorRed
//                self?.textColor = UIColor.Yellows.gryffindorYellow
//                //roundedcorners
//                self?.roundCorners(for: [.topLeft, .topRight], cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
//                self?.layer.masksToBounds = true
//                self?.font =  .systemFont(ofSize: (self?.frame.height)!)
//                self?.textAlignment = .center
//                self?.numberOfLines = 0
//                self?.adjustsFontSizeToFitWidth = true
//                self?.minimumScaleFactor = 0.5
//            }
//    }
    
    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}
