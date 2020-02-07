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
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet weak var responseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundSetup(image: UIImage(named: "solitary")!)
        introduction()
        sentenceSetup()
        //        addTextField()
        
        numberTextFieldSetup()
        responseButtonSetUp()
        
        let myView = Grid()
        
        view.addSubview(myView)
    }
    
    func sentenceSetup() {
        sentence = (CoreDataManager.shared.fetchYearsSentenced(savedObject: "sentence")!).sum()
    }
    
    func numberTextFieldSetup() {
        numberTextField.textAlignment = .center
        numberTextField.setBorder(width: 4, color: UIColor.Shades.standardGrey)
        numberTextField.keyboardType = .numberPad
        numberTextField.roundCorners(for: [.topLeft, .topRight], cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        numberTextField.placeholder = "Sentence..."
        numberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
print ("textfield changed")
        responseButton.isHidden = false
    }
    
    func responseButtonSetUp() {
        responseButton.roundCorners(for: .allCorners, cornerRadius: SingletonClass.sharedInstance.cornerRoundingNumber)
        responseButton.backgroundColor = UIColor(patternImage: UIImage(named: "stone")!)
        responseButton.setTitle("years sir.", for: .normal)
        responseButton.isHidden = true
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
        
        for view in self.view.subviews {
            if let textField = view as? UITextField {
                
                view.viewWithTag(1)?.removeFromSuperview()
                
                guard let years = textField.text else {
                    print ("No value was found in text field")
                    return
                }
                
                if years == String(sentence) {
                    print ("Telling the truth \(years) \(sentence)")
                    addSpeachBubble(text: "Well now I know you are honest, lets see if you are smart enough to bunk with me.\n\nLets give you an easy one.\n\nYou are running a race and pass the preson in second place.\n\nWhat position are you in now?", tag: 2)
                    
                    
                    
                } else {
                    print ("Telling a lie \(years) \(sentence)")
                }
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
        
    }
    
    func addTapToMainScreen() {
        let endGameTap = UITapGestureRecognizer(target: self, action: #selector(self.endGameTap(sender:)))
        view.addGestureRecognizer(endGameTap)
    }
    
    @objc func endGameTap(sender:UITapGestureRecognizer) {
        flowController.showMain()
    }
    
    
    func firstQuestion() {
        view.removeSubviewsWithTag(tag: 1)
        
        guard let years = numberTextField.text else {
            print ("No value was found in text field")
            return
        }

        if years == String(sentence) {
            print ("Telling the truth \(years) \(sentence)")
            addSpeachBubble(text: "Well now I know you are honest, lets see if you are smart enough to bunk with me.\n\nLets give you an easy one.\n\nYou are running a race and pass the person in second place.\n\nWhat position are you in now?", tag: 2)
        } else if years.isEmpty {
            addSpeachBubble(text: "You need to answer me now....", tag: 1)
        } else {
            addSpeachBubble(text: "You think I dont know everything about you.\n\nYou were given \(sentence) years.\n\nNow you have \(sentence) seconds left...", tag: 2)

            //remove/hide all subviews
            self.view.removeSubviewsWithTag(tag: 1)
                   self.view.removeSubviewsWithTag(tag: 2)
                   numberTextField.isHidden = true
                   responseButton.isHidden = true

            UIView.animate(withDuration: 5, delay: 0, options: .transitionCurlDown, animations: { [weak self] in
                self?.view.gameOverScreen()
                
//                self?.addTapToMainScreen()
                self?.view.addTapGestureRecognizer {
                    print ("it works")
                }
            })
            
            
        }
    }
    
    
    @IBAction func numberTextField(_ sender: Any) {
        print ("Im typing")
        
    }
    
    
    @IBAction func responseButton(_ sender: Any) {
 
        firstQuestion()
   
        
    }
    
}
