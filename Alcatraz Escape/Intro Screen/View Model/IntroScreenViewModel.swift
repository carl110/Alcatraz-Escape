//
//  IntroScreenViewModel.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation

class IntroScreenViewModel {
    
    fileprivate var model = IntroScreenModel()
    
    //Randomly select list of crimes and calculate sentence in years
    func crimes() -> (dialog: String, years: Int) {
        var crimeArray = model.crimes
        
        //Set a random number
        let randomNumber = Int.random(in: 3...6)

        //Run through array amnd randomly remove some crimes
        for _ in 0...randomNumber {
            crimeArray.removeValue(forKey: crimeArray.randomElement()!.key)
        }
        var record = "\n\nYou were found guilty of the following crimes"
        var years = 0
        
        //Set dialog for each crime and calculate totla sentence
        for crime in crimeArray {
            record = record + "\n\(crime.key) which carries a sentence of .......... \(crime.value) years"
            years += crime.value
        }
        
        record = record + "\n\nYou have therefore been sentenced to a total of \(years) years to be served in Alcatraz Correctional Facility"
        return (record, years)
    }
    
    func calculateAge(dateOfBirth: Date) -> Int {
        
        //Todays date
          let today = Date()
          
          //Create an instance of the user's current calendar
          let calendar = Calendar.current
          
          //Use calendar to get difference between two dates
          let components = calendar.dateComponents([.year, .month, .day], from: dateOfBirth, to: today)
        
        return components.year!
    } 
}
