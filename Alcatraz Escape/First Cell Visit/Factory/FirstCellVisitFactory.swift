//
//  FirstCellVisitFactory.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class FirstCellVisitFactory {
    
    static func PushIn(navigationController: UINavigationController) {
        
        let storyBoard = UIStoryboard(name: "FirstCellVisit", bundle: nil).instantiateInitialViewController() as! FirstCellVisitViewController
        let flowController = FirstCellVisitFlowController(navigationController: navigationController)
        let viewModel = FirstCellVisitViewModel()
        
        storyBoard.assignDependancies(flowController: flowController, viewModel: viewModel)
        
        
        navigationController.pushViewController(storyBoard, animated: true)
    }
}
