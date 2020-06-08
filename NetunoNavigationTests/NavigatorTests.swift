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

    private let initNavigationControllerIdentifier = Start_TO_GO_SAME_StoryboardViewController.rootNavigationControllerIdentifier

    var navigate: Navigator!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "ToAndGoStoryboard", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: initNavigationControllerIdentifier) as? UINavigationController
        self.navigate = Navigator(navigationController: navigationController)
    }

    override func tearDown() {
        self.navigate = nil
    }
    
    func test_Navigate_NotNil () {
        XCTAssertNotNil(self.navigate, "Navigate should not be nil")
    }
    
    func test_Navigate_NavigationController_Storyboard_notNil () {
        XCTAssertNotNil(self.navigate.navigationController)
        XCTAssertNotNil(self.navigate.navigationController?.storyboard)
    }
    
}
