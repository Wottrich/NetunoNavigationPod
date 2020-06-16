//
//  NavigatorToTests.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import NetunoNavigation
@testable import NetunoNavigationExample

class NavigatorToTests: XCTestCase {

    private let initNavigationControllerIdentifier = Start_TO_GO_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    private let anotherStoryboard = "ToAndGoAnotherStoryboard"
    
    var sut: NavigatorToTestsMock!
    
    override func setUp() {
        
        let storyboard = UIStoryboard(name: "ToAndGoStoryboard", bundle: nil)
        
        self.sut = NavigatorToTestsMock(
            storyboard: storyboard,
            initNavControllerIdentifier: initNavigationControllerIdentifier
        )
    }

    override func tearDown() {
        self.sut = nil
    }

    func test_ToAndGo_ReturnTrue () {
        let to = self.sut.navigate?.to(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(true, to?.go(), ".go() should be true")
    }
    
    func test_ToAndGo_ReturnFalse () {
        let viewController = UIViewController()//ViewController without storyboard
        let to = self.sut.navigate?.to(viewController, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(false, to?.go(), ".go() should not be true")
    }
    
    func test_ToPrepareAndGo () {
        
        self.sut.navigate?.to(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData, "Received Data should be false before .go(...)")
            $0?.receivedData = true
        }.go()
        
        _ = myEspectation({ $0 is Finish_TO_GO_SAME_StoryboardViewController }, sut.navigationController)
        waitForExpectations(timeout: 5)
        
        let currentViewController = sut.currentViewController as? Finish_TO_GO_SAME_StoryboardViewController
        XCTAssertEqual(true, currentViewController?.receivedData, "Received Data should be true after .go(...)")
        
    }
    
    func test_ToAndGo_ReturnTrue_AnotherStoryboard () {
        let to = self.sut.navigate?.to(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to?.go(), ".go() should be true")
    }
    
    func test_ToPrepareAndGo_AnotherStoryboard () {
        self.sut.navigate?.to(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }.go()
        
        _ = myEspectation({ $0 is Start_TO_GO_ANOTHER_StoryboardViewController }, sut.navigationController)
        waitForExpectations(timeout: 5)
        
        let currentViewController = sut.currentViewController as? Start_TO_GO_ANOTHER_StoryboardViewController
        XCTAssertEqual(true, currentViewController?.receivedData, "Received Data should be true after .go(...)")
    }
    
    func test_ToGo_NotNil () {
        XCTAssertNotNil(self.sut.navigate?.toGo(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self))
    }
    
    func test_ToGo () {
        self.sut.navigate?.toGo(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        
        _ = myEspectation({ $0 is Finish_TO_GO_SAME_StoryboardViewController }, sut.navigationController)
        waitForExpectations(timeout: 5)
    }
    
    func test_ToGo_AnotherStoryboard () {
        self.sut.navigate?.toGo(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        
        _ = myEspectation({ $0 is Start_TO_GO_ANOTHER_StoryboardViewController }, sut.navigationController)
        waitForExpectations(timeout: 5)
    }

}
