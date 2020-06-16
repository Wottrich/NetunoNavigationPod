//
//  NewStackSameStoryboardTests.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import NetunoNavigation
@testable import NetunoNavigationExample

class NewStackSameStoryboardTests: XCTestCase {

    private let initNavigationControllerIdentifier = Start_TO_GO_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    private let newStackIdentifier = Start_NEW_STACK_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    
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
    
    func test_newStack_SameStoryboard_Nil () {
        self.sut.navigate?.navigationController = nil
        XCTAssertNil(self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier))
    }
    
    func test_newStack_SameStoryboard_NotNil () {
        XCTAssertNotNil(self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier))
    }
    
    func test_newStack_To_Go () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)!
        let to = newStack?.to(viewControllerToGo: Start_NEW_STACK_SAME_StoryboardViewController.self)
        to?.go()
        
        _ = myEspectation({ $0 is Start_NEW_STACK_SAME_StoryboardViewController }, newStack?.navigationController)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func test_newStack_To_Go_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack?.to(viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        to?.go()
        
        _ = myEspectation({ $0 is Finish_TO_GO_SAME_StoryboardViewController }, newStack?.navigationController)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    func test_newStack_To_Prepare_Go () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)!
        let to = newStack?.to(viewControllerToGo: Start_NEW_STACK_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to?.go()
        
        let viewController = newStack?.navigationController.topViewController as? Start_NEW_STACK_SAME_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_To_Prepare_Go_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack?.to(viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to?.go()
        
        let viewController = newStack?.navigationController.topViewController as? Finish_TO_GO_SAME_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_ToGo () {
           let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)
           let to = newStack?.toGo()
           XCTAssertEqual(true, to?.navigationController.topViewController is Start_NEW_STACK_SAME_StoryboardViewController)
    }
       
    func test_newStack_ToGo_NewViewController () {
        let newStack = self.sut.navigate?.newStack(navControllerToGo: newStackIdentifier)
        let to = newStack?.toGo(Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Finish_TO_GO_SAME_StoryboardViewController)
    }
    
    func test_newStackToGo () {
        let newStack = self.sut.navigate?.newStackToGo(newStackIdentifier)
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_NEW_STACK_SAME_StoryboardViewController)
    }
    
    func test_newStackToGo_NewViewController () {
        let newStack = self.sut.navigate?.newStackToGo(newStackIdentifier, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Finish_TO_GO_SAME_StoryboardViewController)
    }

}
