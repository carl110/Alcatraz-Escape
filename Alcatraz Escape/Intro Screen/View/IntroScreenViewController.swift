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
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dialogLabel: UILabel!
    
    func assignDependancies(flowController: IntroScreenFlowController, viewModel: IntroScreenViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundSetup(image: UIImage(named: "oldPaper")!)
        dialogLabelSetup()
        buttonSetup()
        
    }
    
    func dialogLabelSetup() {
        dialogLabel.text = "Welcome to Alcatraz\nThis will be your new home. You will respect your new home and all of my officers.\nWhen you are asked a questions, you will answer politely and call me and my officers Sir.\nYou will do as you are told.\nNow you will answer some simple questions so we can process you\nDo you understand?"
        dialogLabel.numberOfLines = 0
        dialogLabel.font = UIFont.init(name: "AmericanTypewriter", size: dialogLabel.font.pointSize)
        
    }
    
    func buttonSetup() {
        buttonOne.setTitle("Yes Sir", for: .normal)
        buttonOne.mainButtonSetup()
        buttonTwo.setTitle("No chance Screw...", for: .normal)
        buttonTwo.mainButtonSetup()
        
    }
    
    func addName(title: String,
                 subtitle: String,
                 actionTitle: String,
                 comments: String? = nil,
                 actionHandler: ((_ comment: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        alert.addTextField { (comment:UITextField) in
            comment.placeholder = comments
            
            
        }
        
        let actionButton = UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let commentField =  alert.textFields?[0] else {
                actionHandler?(nil)
                return
            }
            
            actionHandler?(commentField.text)
        })
        alert.addAction(actionButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func buttonOne(_ sender: Any) {
        
        dialogLabel.text = dialogLabel.text! + "\nTell me your name?"
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        
        actionAlertBox(title: "What is your full name", subtitle: "Enter your first and last name", actionTitle: "This is my name Sir.", comments: "Enter name here...") { (name: String?) in
            
            guard let fullName = name, !fullName.isEmpty else {
                print ("name is emptuy")
                return
            }
            
            CoreDataManager.shared.saveName(savedData: fullName)
            self.dialogLabel.text = self.dialogLabel.text! + "\nTell me your name?\n\nMy name is \(fullName) sir."
   
        }
    }
    
}
