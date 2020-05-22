//
//  NavigatorTests.swift
//  NavigatorTests
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import NetunoNavigation
@testable import NetunoNavigationExample

class NavigatorTests: XCTestCase {

    var sut: NavigatorMock!
    var navigate: Navigator!
    
    override func setUp() {
        
        let viewControllersType:[UIViewController.Type] = [
            FinishOneToAndGoViewController.self,
            StartOneToAndGoViewController.self
        ]
        
        self.sut = NavigatorMock(storyboardName: "ToAndGoStoryboard", bundle: nil, viewControllersType: viewControllersType)
        
        self.navigate = Navigator(navigationController: sut.navigationController)
    }

    override func tearDown() {
        self.sut = nil
        self.navigate = nil
    }

    func test_navigationAndCurrentVIewControllerNotNil () {
        XCTAssertNotNil(sut, "Sut must not be nul")
        XCTAssertNotNil(sut.currentViewController, "CurrentViewController must not be nil")
    }
    
    func test_toAndGoToAnotherViewController () {
        
        XCTAssertNotNil(sut.currentViewController, "CurrentViewController must not be nil")
        XCTAssertEqual(true, sut.validTopViewController(type: StartOneToAndGoViewController.self))
        
        let to = navigate.to(sut.currentViewController!, viewControllerToGo: FinishOneToAndGoViewController.self)
        
        XCTAssertNotNil(to, "Function to need return GO not nil")
        
        let result = to.go()
        
        XCTAssertEqual(true, result, "Result must be true")
        
        _ = expectation(
            for: sut.predicate{ $0 is FinishOneToAndGoViewController },
            evaluatedWith: sut.navigationController,
            handler: .none
        )
        
        waitForExpectations(timeout: 5, handler: .none)
        
    }

}
