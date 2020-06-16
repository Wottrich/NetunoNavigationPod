//
//  NewStackAnotherStoryboardTests.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import NetunoNavigation
@testable import NetunoNavigationExample

class NewStackAnotherStoryboardTests: XCTestCase {
    
    private let initNavigationControllerIdentifier = Start_TO_GO_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    private let newStackAnotherStoryboardIdentifier = Start_NEW_STACK_ANOTHER_StoryboardViewController.rootNavigationControllerIdentifier
    private let newStackIdentifier = Start_NEW_STACK_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    private let anotherStoryboard = "ToAndGoAnotherStoryboard"
    
    var sut: NewStackTestsMock!
    
    override func setUp() {
        self.sut = NewStackTestsMock(
            storyboard: UIStoryboard(name: "ToAndGoStoryboard", bundle: nil),
            navigationControllerIdentifier: initNavigationControllerIdentifier
        )
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    func test_newStack_To_Go_AnotherStoryboard () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        let to = newStack?.to(viewControllerToGo: Start_NEW_STACK_ANOTHER_StoryboardViewController.self)
        to?.go()
        
        _ = myEspectation({ $0 is Start_NEW_STACK_ANOTHER_StoryboardViewController }, newStack?.navigationController)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func test_newStack_To_Go_AnotherStoryboard_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack?.to(viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        to?.go()
        
        _ = myEspectation({ $0 is Start_TO_GO_ANOTHER_StoryboardViewController }, newStack?.navigationController)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func test_newStack_To_Prepare_Go_AnotherStoryboard () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        let to = newStack?.to(viewControllerToGo: Start_NEW_STACK_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to?.go()
        
        let viewController = newStack?.navigationController.topViewController as? Start_NEW_STACK_ANOTHER_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
    }
    
    func test_newStack_To_Prepare_Go_AnotherStoryboard_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack?.to(viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to?.go()
        
        let viewController = newStack?.navigationController.topViewController as? Start_TO_GO_ANOTHER_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_ToGo_AnotherStoryboard () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)
        let to = newStack?.toGo(Start_NEW_STACK_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Start_NEW_STACK_ANOTHER_StoryboardViewController)
    }
    
    func test_newStack_ToGo_AnotherStoryboard_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)
        let to = newStack?.toGo(Start_TO_GO_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Start_TO_GO_ANOTHER_StoryboardViewController)
    }
    
    func test_newStackToGo_AnotherStoryboard () {
        let newStack = self.sut.navigate?.newStackToGo(newStackAnotherStoryboardIdentifier, anotherStoryboard)
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_NEW_STACK_ANOTHER_StoryboardViewController)
    }
    
    func test_newStackToGo_AnotherStoryboard_NewViewController () {
        let newStack = self.sut.navigate?.newStackToGo(
            newStackAnotherStoryboardIdentifier,
            anotherStoryboard,
            viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self
        )
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_TO_GO_ANOTHER_StoryboardViewController)
    }
    
}
