//
//  ViewController.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 23/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var mainFlowController: MainFlowController!
    
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var continueGameButton: UIButton!
    
    func assignDependancies(mainFlowController: MainFlowController) {
        self.mainFlowController = mainFlowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup(image: UIImage(named: "paintedAlcatrazIsland")!)
        buttonSetup()
    }
    
    func buttonSetup() {
        startNewGameButton.setTitle("Start New Game", for: .normal)
        startNewGameButton.mainButtonSetup()
        continueGameButton.mainButtonSetup()
        continueGameButton.setTitle("Continue Game", for: .normal)
    }
    
    //Create a label inside of a scrollview
    func addLabel() {
        var labelTwo: UILabel  {
            let label = UILabel()
            label.text = "The June 1962 Alcatraz escape was a prison break from Alcatraz Federal Penitentiary, a maximum-security facility located on an island in San Francisco Bay, undertaken by inmates Frank Morris and brothers John and Clarence Anglin. The three men were able to escape from their cells and leave the island in a makeshift raft. It remains unknown what happened to them after entering San Francisco Bay. A fourth inmate, Allen West, did not manage to escape his cell in time to join the others and decided to abort his escape attempt. The escape was marked by elaborate planning and execution, including crafting dummy heads to fool the guards, making of improvised tools and of a raft.\n\nIn 1979, the FBI officially closed their investigation, concluding that the men drowned in the frigid waters of San Francisco Bay while trying to reach land. The U.S. Marshals Service continues the investigation, keeping the escapees on its wanted list. New circumstantial and material evidence continues to surface up, stoking further research and debates on whether the inmates managed to survive. \n\n\n\n\n NOW ITS YOUR TURN...\n\n\n\n"
            
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.frame = CGRect(x: 40, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height)
            label.backgroundColor = UIColor.Shades.standardGrey
            label.alpha = 0.9
            label.isUserInteractionEnabled = true
            
            //Add Tap gesture to label
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(sender:)))
            label.addGestureRecognizer(tap)
            return label
        }
        
        //Setup scrolllview
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: screenHeight))
        scrollView.addSubview(labelTwo)
        
        //Scroll the text from bottom to origin point
        UIView.animate(withDuration: 10, animations: {
            scrollView.contentOffset = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
        })
        
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        view.addSubview(scrollView)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        mainFlowController.showIntroScreen()
    }
    
    @IBAction func startNewGameButton(_ sender: Any) {
        
        //Remove buttons then scroll the initial text
        startNewGameButton.disableButton()
        continueGameButton.disableButton()
        addLabel()
    }
    @IBAction func continueGameButton(_ sender: Any) {
        
        //Area to add function for continuing game
        
        mainFlowController.showIntroScreen()
    }
}

