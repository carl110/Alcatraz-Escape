//
//  MainFlowController.swift
//  table setp
//
//  Created by Carl Wainwright on 20/12/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MainFlowController {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //Factory of view to show
        func showIntroScreen() {
            IntroScreenFactory.PushIn(navigationController: navigationController)
            
        }
    
    func showScreenImWorkingOn() {
        FirstCellVisitFactory.PushIn(navigationController: navigationController)
    }
}
