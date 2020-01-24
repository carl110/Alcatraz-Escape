//
//  UITextFields+extensions.swift
//  Maths Genius
//
//  Created by Carl Wainwright on 29/08/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    //Check if UITextField is empty
    var isEmpty: Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
}
