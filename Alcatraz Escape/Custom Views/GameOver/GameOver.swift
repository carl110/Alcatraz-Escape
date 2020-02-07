//
//  GameOver.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 06/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit
import UIKit

class GameOver: UIView {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    func viewSetup() {
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.textColor = UIColor.Shades.standardWhite
        gameOverLabel.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.height / 3)
        
        backgroundSetup(image: UIImage(named: "paintedAlcatrazIsland")!)
        
        backgroundView.fadeIn()
        
        restartButton.buttonSetup()
        restartButton.setTitle("Restart the Game", for: .normal)
        
    }
    
    func fadeInRed() {

        backgroundView.backgroundColor = UIColor.red
        backgroundView.alpha = 0.9
    }

    func backgroundSetup(image: UIImage) {
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }
    
    
    @IBAction func restartButton(_ sender: Any) {
    }
    
    
}
