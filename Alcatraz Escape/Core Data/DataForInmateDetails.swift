//
//  DataForInmateDetails.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 27/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataForInmateDetails {
    
    var name: String
    var dateOfBirth: Date
    var crime: String
    var gridSize: Int16
    var sentence: Int16
    
    init (object: NSManagedObject) {
        self.name = object.value(forKey: "name") as! String
        self.dateOfBirth =  object.value(forKey: "dateOfBirth") as! Date
        self.crime = object.value(forKey: "crime") as! String
        self.gridSize = object.value(forKey: "gridSize") as! Int16
        self.sentence = object.value(forKey: "sentence") as! Int16
    }
}
