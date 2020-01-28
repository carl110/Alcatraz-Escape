//
//  TheHoleFlowController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TheHoleFlowController {
        let navigationController: UINavigationController
        
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
    //Factory of view to show
        func showMain() {
            MainFactory.PushIn(navigationController: navigationController)
            
        }
    
    func showTheHole() {
        MainFactory.PushIn(navigationController: navigationController)
        
    }
}
