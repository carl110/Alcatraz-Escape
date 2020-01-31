//
//  TheHoleViewModel.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TheHoleViewModel {
    
    
    let photoArray = [UIImage(named: "paintedAlcatrazIsland"),
                     UIImage(named: "solitary")]
    
   
    let gridSize: Int
    let photo: UIImage
    var puzzleDictionary: [Int:UIImage]
    var images: [UIImage]
    
    init(gridSize: Int) {
        
        self.gridSize = gridSize
        self.photo = photoArray.randomElement()!!
        self.puzzleDictionary = photo.splitImage(gridSize)
        self.images = puzzleDictionary.values.map{$0}
        
    }
    
}
