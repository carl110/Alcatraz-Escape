//
//  UIViewController+extensions.swift
//  Maths Genius
//
//  Created by Carl Wainwright on 30/08/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //returns String as Int from UItextField
    func integer(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return 0
        }
        return number
    }
    
    //alert box with switch to show options per button set up
    func alertBoxWithAction(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Move viewcontroller back in stck by n
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    //hide device keyboard when tapped outside of keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Shows standart aler message
    func alert(message: String, title: String = "") {
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(OKAction)
         self.present(alertController, animated: true, completion: nil)
     }
    
    
    //insert image as background
    func backgroundSetup(image: UIImage) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //Alertbox with text fields
    func showGoalTaskDialog(title: String? = nil,
                         subtitle: String? = nil,
                         actionTitle: String? = "Add",
                         textInput1: String? = nil,
                         textInput2: String? = nil,
                         textInput3: String? = nil,
                         textInput4: String? = nil,
                         actionHandler: ((_ goal: String?, _ task1: String?, _ task2: String?, _ task3: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (goalText:UITextField) in
            goalText.placeholder = textInput1
        }
        alert.addTextField { (task1Text: UITextField) in
            task1Text.placeholder = textInput2
        }
        alert.addTextField { (task2Text: UITextField) in
            task2Text.placeholder = textInput3
        }
        alert.addTextField { (task3Text: UITextField) in
            task3Text.placeholder = textInput4
        }
        
        let actionButton = UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let goalField =  alert.textFields?[0] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task1Field = alert.textFields?[1] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task2Field = alert.textFields?[2] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task3Field = alert.textFields?[3] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            actionHandler?(goalField.text, task1Field.text, task2Field.text, task3Field.text)
        })
        alert.addAction(actionButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func actionAlertBox(title: String?,
                            subtitle: String?,
                            actionTitle: String?,
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
    
}
