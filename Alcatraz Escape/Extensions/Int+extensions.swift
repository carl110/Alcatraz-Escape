//
//  Int+extensions.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 11/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    //Add correct suffix to number position
    var ordinal: String {
        get {
            var suffix = "th"
            switch self % 10 {
                case 1:
                    suffix = "st"
                case 2:
                    suffix = "nd"
                case 3:
                    suffix = "rd"
                default: ()
            }
            if 10 < (self % 100) && (self % 100) < 20 {
                suffix = "th"
            }
            return String(self) + suffix
        }
    }
    
    //Returns year if number is 1
    var years: String {
        var year = " years"
        if self == 1 {
            year = " year"
        }
    return String(self) + year
    }
}
