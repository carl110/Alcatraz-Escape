//
//  IntroScreenFactory.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class IntroScreenFactory {
    
    static func PushIn(navigationController: UINavigationController) {
        
        let storyBoard = UIStoryboard(name: "IntroScreen", bundle: nil).instantiateInitialViewController() as! IntroScreenViewController
        let flowController = IntroScreenFlowController(navigationController: navigationController)
        let viewModel = IntroScreenViewModel()
        
        storyBoard.assignDependancies(flowController: flowController, viewModel: viewModel)
        
        
        navigationController.pushViewController(storyBoard, animated: true)
    }
}
