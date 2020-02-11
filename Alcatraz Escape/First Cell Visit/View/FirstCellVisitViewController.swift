//
//  FirstCellVisitViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class FirstCellVisitViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var flowController: FirstCellVisitFlowController!
    fileprivate var viewModel: FirstCellVisitViewModel!
    
    private var sentence = Int16()
    private var question = 1
    private var textFields = [UITextField]()
    
    func assignDependancies(flowController: FirstCellVisitFlowController, viewModel: FirstCellVisitViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet weak var responseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup(image: UIImage(named: "solitary")!)
        introduction()
        numberTextFieldSetup()
        responseButtonSetUp()
        hideKeyboardWhenTappedAround()
        sentence = (CoreDataManager.shared.fetchYearsSentenced(savedObject: "sentence")!).sum()
        numberTextField.delegate = self
    }
    
    func numberTextFieldSetup() {
        numberTextField.textAlignment = .center
        numberTextField.setBorder(width: 4, color: UIColor.Shades.standardGrey)
        numberTextField.keyboardType = .numberPad
        numberTextField.roundCorners(for: [.topLeft, .topRight], cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        numberTextField.placeholder = "Insert Number..."
        numberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
        numberTextField.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
    }
    
    //unhide button when textfield touched
    @objc func textFieldDidChange(_ textField: UITextField) {
        responseButton.isHidden = false
    }
    
    //update button title for response
    @objc func textFieldTyping() {
        
        let textNumber = Int(numberTextField.text!)
        guard let number = textNumber else {
            responseButton.setTitle("Why should I tell you‽‽‽‽", for: .normal)
            return
        }
        
        if question == 1 {
            responseButton.setTitle("They gave me \(number.years) Mr Ray Sir", for: .normal)
        } else if question == 2 {
            responseButton.setTitle("I would be in \(number.ordinal) Mr Ray Sir", for: .normal)
        }
    }
    
    //Only allow numbers in text field, even when a user uses a conected keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField{
            let allowingChars = "0123456789"
            let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
            let validString = string.rangeOfCharacter(from: numberOnly) == nil
            return validString
        }
        return true
    }
    
    func responseButtonSetUp() {
        responseButton.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        responseButton.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
        responseButton.setTitle("Why should I tell you‽‽‽‽", for: .normal)
        responseButton.isHidden = true
        responseButton.setTitleColor(UIColor.Shades.standardBlack, for: .normal)
    }
    
    //show rap sheet on intial load
    func introduction() {
        let rayDetails = UIImageView(image: UIImage( named: "alvinKarpis"))
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
    }
    
    func firstQuestion() {
        view.removeSubviewsWithTag(tag: 1)
        
        guard let years = numberTextField.text else {
            print ("No value was found in text field")
            return
        }
        if years == String(sentence) {
            print ("Telling the truth \(years) \(sentence)")
            addSpeachBubble(text: "Well now I know you are honest, lets see if you are smart enough to bunk with me.\n\nLets give you an easy one.\n\nYou are running a race with 9 other people. You pass the person in second place.\n\nWhat position are you in now?", tag: 1)
            responseButton.setTitle("Why should I tell you‽‽‽‽", for: .normal)
            responseButton.isHidden = true
            question = 2
        } else if years.isEmpty {
            addSpeachBubble(text: "You need to answer me now....", tag: 1)
        } else {
            addSpeachBubble(text: "You think I dont know everything about you.\n\nYou were given \(sentence) years.\n\nNow you have \(sentence) seconds...", tag: 2)
            
            //remove/hide all subviews
            self.view.removeSubviewsWithTag(tag: 1)
            numberTextField.isHidden = true
            responseButton.isHidden = true
            
            //Add countdown timer and retry button
            
            UIView.animate(withDuration: 5, delay: TimeInterval(sentence), options: .transitionCurlDown, animations: { [weak self] in
                self?.view.gameOverScreen()
                
                self?.view.addTapGestureRecognizer {
                    self?.flowController.showMain()
                }
            })
        }
        numberTextField.text = ""
    }
    
    func secondQuestion() {
        view.removeSubviewsWithTag(tag: 1)
        
        guard let placement = numberTextField.text else {
            print ("No value was found in text field")
            return
        }
        
        if placement == "2" {
            addSpeachBubble(text: "Well well. Finally they send me someone with a bit of smarts.\n\nYou could be useful.", tag: 2)
        } else {
            addSpeachBubble(text: "I can't stand stupid people.\n\nLeave now before you have an accident.", tag: 2)
        }
    }
    
    @IBAction func numberTextField(_ sender: UITextField) {
    }
    
    
    @IBAction func responseButton(_ sender: Any) {
        
        //Hide keyboard when button pressed
        view.resignFirstResponder()
        
        if question == 1 {
            firstQuestion()
        } else if question == 2 {
            secondQuestion()
        }
    }
}
