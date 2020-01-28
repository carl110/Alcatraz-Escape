//
//  DatePickerView.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 28/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class DatePickerView: UIDatePicker {
    
    let monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let yearArray = Array(1900...Calendar.current.component(.year, from: Date()))

    override func awakeFromNib() {

             // Create a DatePicker
             let datePicker: UIDatePicker = UIDatePicker()
             

             
             // Set some of UIDatePicker properties
             datePicker.timeZone = NSTimeZone.local
             datePicker.backgroundColor = UIColor.white
        
        self.datePickerMode = .date
             
             // Add an event to call onDidChangeDate function when value is changed.
             datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        

    }
    
    
    
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }
    

    

}
