//
//  CGPoint+extensions.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 29/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    //show distance between 2 points using Pythagoras Therom
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2))
    }
    func vector(toPoint p:CGPoint) -> CGPoint {
        return CGPoint(x: x - CGFloat(p.x), y: y - CGFloat(p.y))
    }
}
