//
//  IntroScreenViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController {
    
    fileprivate var flowController: IntroScreenFlowController!
    fileprivate var viewModel: IntroScreenViewModel!
    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var introLabel: UILabel!
    
    func assignDependancies(flowController: IntroScreenFlowController, viewModel: IntroScreenViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundSetup()
    }
    
    func backgroundSetup() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "paintedAlcatrazIsland")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}
