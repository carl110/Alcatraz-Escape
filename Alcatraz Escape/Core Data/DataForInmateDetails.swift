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
    var dateOfBirth: String
    var crime: String
    
    init (object: NSManagedObject) {
        self.name = object.value(forKey: "name") as! String
        self.dateOfBirth =  object.value(forKey: "dateOfBirth") as! String
        self.crime = object.value(forKey: "crime") as! String
    }
}
