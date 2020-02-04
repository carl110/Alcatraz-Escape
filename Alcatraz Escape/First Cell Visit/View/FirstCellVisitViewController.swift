//
//  FirstCellVisitViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class FirstCellVisitViewController: UIViewController {
    
    fileprivate var flowController: FirstCellVisitFlowController!
    fileprivate var viewModel: FirstCellVisitViewModel!
    
    func assignDependancies(flowController: FirstCellVisitFlowController, viewModel: FirstCellVisitViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundSetup(image: UIImage(named: "solitary")!)
        introduction()
    }
    
    func alvinKarpisSpeach() {
        let speach = "Hey, my guys call me Ray. If you are going to bunk wit me you need to show you are trust worthy and smart.\nHow long is your sentence?"
    }
    
    func introduction() {
        let rayDetails = UIImageView(image: UIImage( named: "alvinKarpis"))
//        rayDetails.frame.size.height = UIScreen.main.bounds.height - 40
        rayDetails.frame.size = CGSize(width: (UIScreen.main.bounds.height - 40) * 1.6, height: UIScreen.main.bounds.height - 40)
        rayDetails.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        self.view.addSubview(rayDetails)
        rayDetails.tag = 159
        rayDetails.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(sender:)))
        rayDetails.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.view.viewWithTag(159)?.removeFromSuperview()
        print ("screen touched")
    }
    
}
