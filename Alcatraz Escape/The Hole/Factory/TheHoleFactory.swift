//
//  TheHoleFactory.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TheHoleFactory {
    
    static func PushIn(navigationController: UINavigationController, gridSize: Int) {
        
        let storyBoard = UIStoryboard(name: "TheHole", bundle: nil).instantiateInitialViewController() as! TheHoleViewController
        let flowController = TheHoleFlowController(navigationController: navigationController)
        let viewModel = TheHoleViewModel(gridSize: gridSize)
        
        storyBoard.assignDependancies(flowController: flowController, viewModel: viewModel)
        
        
        navigationController.pushViewController(storyBoard, animated: true)
    }
}
