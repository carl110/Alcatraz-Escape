//
//  GamePlayUICollectionViewCell.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 30/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class PuzzleCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var userImageView: UIImageView!
    //add array of images as cells
    func config (puzzleImages: UIImage) {
        userImageView.image = puzzleImages
    }
    
    override func prepareForReuse() {
        userImageView.image = UIImage()
    }
}
