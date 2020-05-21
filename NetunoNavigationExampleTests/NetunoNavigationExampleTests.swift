//
//  NetunoNavigationExampleTests.swift
//  NetunoNavigationExampleTests
//
//  Created by Wottrich on 21/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import NetunoNavigation
@testable import NetunoNavigationExample

class NetunoNavigationExampleTests: XCTestCase {

    var sut: StartOneToAndGoViewController!
    
    override func setUp() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ToAndGoStoryboard", bundle: nil)
        
        sut = storyboard.instantiateViewController(identifier: "StartOneToAndGoViewController") as? StartOneToAndGoViewController
        
        
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }


    func test_shouldHasNavigateInstantieted () {
        XCTAssertNotNil(sut.navigate)
    }
    
    func test_shouldGoNextViewControllerWithoutPrepareOnCurrentStoryboard () {
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.navigate)
        
        sut.didTapNextViewControllerWithoutPrepareOnCurrentStoryboard(nil)
        
        _ = expectation(for: NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is FinishOneToAndGoViewController
        }, evaluatedWith: sut.navigationController, handler: .none)
        
        waitForExpectations(timeout: 10, handler: .none)
        
    }
    
}
