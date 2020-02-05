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
    
    private var sentence = Int16()
    private var playerResponse = String()
    private var textFields = [UITextField]()
    
    func assignDependancies(flowController: FirstCellVisitFlowController, viewModel: FirstCellVisitViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundSetup(image: UIImage(named: "solitary")!)
        introduction()
        
//        addTextField()
    }
    
    func sentenceSetup() {
        sentence = (CoreDataManager.shared.fetchYearsSentenced(savedObject: "sentence")!).sum()
    }

    func addTextField() {
        let numberTextField = UITextField()
        numberTextField.frame.size = CGSize(width: 100, height: 50)
        numberTextField.center.x = view.center.x
        numberTextField.center.y = view.bounds.minY + numberTextField.bounds.height
        numberTextField.textAlignment = .center
        numberTextField.setBorder(width: 4, color: UIColor.Shades.standardGrey)
        numberTextField.keyboardType = .numberPad
        numberTextField.roundCorners(for: [.topLeft, .topRight], cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        numberTextField.placeholder = "Sentence..."
        numberTextField.backgroundColor = UIColor.Shades.standardWhite
        numberTextField.tag = 13
        textFields.append(numberTextField)
        view.addSubview(numberTextField)
    }

    func addSentenceButton() {
        let button = UIButton()
        button.frame.size = CGSize(width: 200, height: 50)
        button.center.x  = view.center.x
        button.center.y = view.bounds.minY + 100
        button.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        button.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("years sir.", for: .normal)
        view.addSubview(button)
    }
    
    @objc func buttonAction() {
//        print ("playerResponse = \(view.tag)")
        
        for view in self.view.subviews {
             if let textField = view as? UITextField {
                 print(textField.text!)
             }
         }
        
        sentenceSetup()
    }
    
    func introduction() {
        let rayDetails = UIImageView(image: UIImage( named: "alvinKarpis"))
        //        rayDetails.frame.size.height = view.bounds.height - 40
        rayDetails.frame.size = CGSize(width: (view.bounds.height - 40) * 1.6, height: view.bounds.height - 40)
        rayDetails.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        self.view.addSubview(rayDetails)
        rayDetails.tag = 159
        rayDetails.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(sender:)))
        rayDetails.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.view.viewWithTag(159)?.removeFromSuperview()
        
        addSpeachBubble(text: "Hey, my guys call me Ray.\n\nIf you are going to bunk with me you need to show you are trust worthy and smart.\n\nHow long is your sentence?", tag: 1)
        
        addTextField()
        addSentenceButton()
    }
    
}
