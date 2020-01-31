//
//  UIImage+extensions.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 29/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    //splits an image into (X²) pieces
    func splitImage(_ rowsandcolumns: Int) -> [Int: UIImage] {
        let rows = rowsandcolumns
        let columns = rowsandcolumns
        let y = (size.height / CGFloat(rows)).rounded()
        let x = (size.width / CGFloat(columns)).rounded()
        var images = [Int: UIImage]()
        images.reserveCapacity(rows * columns)
        guard let cgImage = cgImage else { return [:] }
        (0..<rows).forEach { row in
            (0..<columns).forEach { column in
                var width = Int(x)
                var height = Int(y)
                if row == rows-1 && size.height.truncatingRemainder(dividingBy: CGFloat(rows)) != 0 {
                    height = Int(size.height - size.height / CGFloat(rows) * (CGFloat(rows)-1))
                }
                if column == columns-1 && size.width.truncatingRemainder(dividingBy: CGFloat(columns)) != 0 {
                    width = Int(size.width - (size.width / CGFloat(columns) * (CGFloat(columns)-1)))
                }
                if let image = cgImage.cropping(to: CGRect(origin: CGPoint(x: column * Int(x), y:  row * Int(x)), size: CGSize(width: width, height: height))) {
                    images[images.count] = UIImage(cgImage: image, scale: scale, orientation: imageOrientation)
                
                }
            }
        }
        return images
    }
}
