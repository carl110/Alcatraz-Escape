//
//  TheHoleViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class TheHoleViewController: UIViewController {
    
    fileprivate var flowController: TheHoleFlowController!
    fileprivate var viewModel: TheHoleViewModel!
    
    @IBOutlet weak var button: UIButton!
    func assignDependancies(flowController: TheHoleFlowController, viewModel: TheHoleViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }

         
         override func viewDidLoad() {
             super.viewDidLoad()

         }
         
}

