//
//  sequence+extensions.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 05/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    
    func sum() -> Element {
        reduce(.zero, +)
    }


}
