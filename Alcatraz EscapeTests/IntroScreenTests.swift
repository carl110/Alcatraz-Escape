//
//  IntroScreenTests.swift
//  Alcatraz EscapeTests
//
//  Created by Carl Wainwright on 31/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import XCTest
@testable import Alcatraz_Escape

class IntroScreenTests: XCTestCase {

    let introScreenViewModel = IntroScreenViewModel()
    
    func testGetCrimes() {
        XCTAssertNotNil(introScreenViewModel.crimes)
    }
    
    

}
