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
    
    
    let photo = UIImage(named: "paintedAlcatrazIsland")
    let gridSize = 2

    var puzzleDictionary: [Int:UIImage]
    var images: [UIImage]
    
    init() {
        
        self.puzzleDictionary = photo!.splitImage(gridSize)
        self.images = puzzleDictionary.values.map{$0}
    }
    
}
