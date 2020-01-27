//
//  MainViewModel.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 24/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MainViewModel {

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

