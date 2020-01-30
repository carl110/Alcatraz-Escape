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
    
    private let dobDatePicker : UIDatePicker = UIDatePicker()
    private var dateOfBirth = String()
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var guardQuestions: UILabel!
    
    func assignDependancies(flowController: IntroScreenFlowController, viewModel: IntroScreenViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundSetup(image: UIImage(named: "oldPaper")!)
        dialogLabelSetup()
        buttonSetup()
        guardQuestionSetup()
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
    
    func guardQuestionSetup() {
        guardQuestions.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
        guardQuestions.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        guardQuestions.textAlignment = .center
        guardQuestions.font = UIFont(name: "AmericanTypewriter", size: dialogLabel.font.pointSize * 2)
        guardQuestions.sizeToFit()
        guardQuestions.alpha = 0
    }

    func whatIsYourName() {
        guardQuestions.alpha = 1
        
        guardQuestions.text = "What is your full name?"
        
        //        dialogLabel.text = dialogLabel.text! + "\nTell me your name?"
               actionAlertBox(title: "Enter your first and last name below", subtitle: nil, actionTitle: "Confirm", comments: "Enter name here...") { [weak self] (name: String?) in
                 
                 guard let fullName = name, !fullName.isEmpty else {
                     print ("name is emptuy")
                     return
                 }
                 
//                 CoreDataManager.shared.saveName(savedData: fullName)
                self?.dialogLabel.text = (self?.dialogLabel.text)! + "\nTell me your name?\n*****My name is \(fullName) sir.*****"
                
                self?.whatsYourDateOfBirth()
             }
    }
    
    func whatsYourDateOfBirth() {
         
        
        //set to date only
        dobDatePicker.datePickerMode = .date
        
        //set max date to (today)
        dobDatePicker.maximumDate = Date()
        
            dobDatePicker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
        
        //set width to what is needed and location
            let pickerSize : CGSize = dobDatePicker.sizeThatFits(CGSize.zero)
        dobDatePicker.frame = CGRect(x: dialogLabel.bounds.minX + (dialogLabel.bounds.width / 3),
                              y: guardQuestions.bounds.height * 2 + 20,
                              width:pickerSize.width,
                              height: dialogLabel.bounds.height - (guardQuestions.bounds.height * 2))
        
        dobDatePicker.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        
        dobDatePicker.setValue(UIColor.Shades.standardBlack, forKey: "textColor")
        dobDatePicker.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
    
            // picker.backgroundColor = UIColor.blackColor()
            self.view.addSubview(dobDatePicker)
        
        guardQuestions.text = "Whats your Date of Birth?"
        }
        @objc func dueDateChanged(sender:UIDatePicker){
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            
            dateOfBirth = dateFormatter.string(from: sender.date)

            buttonOne.setTitle("I was born on \(dateOfBirth), Sir.", for: .normal)
            
            buttonOne.enableButton()
            buttonTwo.enableButton()
        }
    
    
    @IBAction func buttonOne(_ sender: Any) {
        
        if buttonOne.titleLabel?.text == "Yes Sir" {
             whatIsYourName()
            buttonOne.disableButton()
            buttonTwo.disableButton()
            buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: (buttonOne.titleLabel?.font.pointSize)! / 2)
            buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: (buttonTwo.titleLabel?.font.pointSize)! / 2)
        } else {
            
            dobDatePicker.removeFromSuperview()
            dialogLabel.text = (dialogLabel.text)! + "\nWhats your date of birth?\n*****I was born on \(dateOfBirth) sir.*****"
        }
       
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        
        flowController.ShowTheHole()

    }
    
    
}
