//
//  Grid.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 29/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

//Draw a gird using grid sze which can be changed

class Grid: UIView {
    
    private var path = UIBezierPath()
    var gridSize: CGFloat = 4 {
        didSet {
            drawGrid()
        }
    }

    override func draw(_ rect: CGRect) {
        drawGrid()
        UIColor.gray.setStroke()
        path.stroke()
    }

    fileprivate var gridWidth: CGFloat {

        return bounds.width/CGFloat(gridSize)
    }

    fileprivate func drawGrid() {
        
        if let subLayer = self.layer.sublayers {
            for layer in subLayer {
                layer.removeFromSuperlayer()
            }
        }

        let gridLayer = CAShapeLayer()
        path = UIBezierPath()
        path.lineWidth = 4
        
        //Horizontal grid lines
        for index in 0...Int(gridSize) {
            let start = CGPoint(x: 0, y: CGFloat(index) * gridWidth)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridWidth)
            path.move(to: start)
            path.addLine(to: end)
        }
        
        //vertical grid lines
        for index in 0...Int(gridSize) {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0 )
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }
        path.close()
        self.layer.addSublayer(gridLayer)
        self.setNeedsDisplay()
    }

}
