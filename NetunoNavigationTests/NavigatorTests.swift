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
    private let newStackAnotherStoryboardIdentifier = Start_NEW_STACK_ANOTHER_StoryboardViewController.rootNavigationControllerIdentifier
    private let newStackIdentifier = Start_NEW_STACK_SAME_StoryboardViewController.rootNavigationControllerIdentifier
    private let anotherStoryboard = "ToAndGoAnotherStoryboard"
    
    var sut: NavigatorMock!
    var sutAnotherStoryboard: NavigatorMock!
    var navigate: Navigator!
    
    override func setUp() {
        
        let viewControllersType:[UIViewController.Type] = [
            Start_TO_GO_SAME_StoryboardViewController.self
        ]
        
        let storyboard = UIStoryboard(name: "ToAndGoStoryboard", bundle: nil)
        
        guard let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene})
            .compactMap({$0}).first?.windows
            .filter({$0.isKeyWindow}).first
        else {
            XCTFail("Window should not be null")
            return
        }
        
        self.sut = NavigatorMock(
            window: window,
            storyboard: storyboard,
            initNavController: initNavigationControllerIdentifier,
            anotherNavController: newStackIdentifier,
            viewControllersType: viewControllersType
        )
        
        self.navigate = Navigator(navigationController: sut.navigationController)
    }

    override func tearDown() {
        self.sut = nil
        self.navigate = nil
    }

    func test_Navigation_CurrentViewController_NotNil () {
        XCTAssertNotNil(sut, "Sut should not be nul")
        XCTAssertNotNil(sut.currentViewController, "CurrentViewController should not be nil")
    }
    
    func test_Navigate_NotNil () {
        XCTAssertNotNil(self.navigate, "Navigate should not be nil")
    }
    
    func test_Navigate_NavigationController_Storyboard_notNil () {
        XCTAssertNotNil(self.navigate.navigationController)
        XCTAssertNotNil(self.navigate.navigationController?.storyboard)
    }
    
    func test_To_NotNil () {
        XCTAssertNotNil(self.navigate.to(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self))
    }
    
    func test_Go_ReturnTrue () {
        let to = self.navigate.to(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(true, to.go(), ".go() should be true")
    }
    
    func test_Go_ReturnFalse () {
        let viewController = UIViewController()//ViewController without storyboard
        let to = self.navigate.to(viewController, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(false, to.go(), ".go() should not be true")
    }
    
    func test_To_Prepare_Go () {
        
        self.navigate.to(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData, "Received Data should be false before .go(...)")
            $0?.receivedData = true
        }.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Finish_TO_GO_SAME_StoryboardViewController },
            evaluatedWith: sut.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
        let currentViewController = sut.currentViewController as? Finish_TO_GO_SAME_StoryboardViewController
        XCTAssertEqual(true, currentViewController?.receivedData, "Received Data should be true after .go(...)")
        
    }
    
    func test_To_AnotherStoryboard_NoThrow () {
        XCTAssertNoThrow(self.navigate.to(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self))
    }
    
    func test_Go_ReturnTrue_AnotherStoryboard () {
        let to = self.navigate.to(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to.go(), ".go() should be true")
    }
    
    func test_To_Prepare_Go_AnotherStoryboard () {
        self.navigate.to(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Start_TO_GO_ANOTHER_StoryboardViewController },
            evaluatedWith: sut.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
        let currentViewController = sut.currentViewController as? Start_TO_GO_ANOTHER_StoryboardViewController
        XCTAssertEqual(true, currentViewController?.receivedData, "Received Data should be true after .go(...)")
    }
    
    func test_ToGo_NotNil () {
        XCTAssertNotNil(self.navigate.toGo(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self))
    }
    
    func test_ToGo () {
        self.navigate.toGo(sut.currentViewController!, viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        
        _ = expectation(
            for: sut.predicate{ $0 is Finish_TO_GO_SAME_StoryboardViewController },
            evaluatedWith: sut.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_ToGo_AnotherStoryboard () {
        
        self.navigate.toGo(anotherStoryboard, viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        
        _ = expectation(
            for: sut.predicate{ $0 is Start_TO_GO_ANOTHER_StoryboardViewController },
            evaluatedWith: sut.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_newStack_SameStoryboard_Nil () {
        self.navigate.navigationController = nil
        XCTAssertNil(self.navigate.newStack(navControllerToGo: newStackIdentifier))
    }
    
    func test_newStack_SameStoryboard_NotNil () {
        XCTAssertNotNil(self.navigate.newStack(navControllerToGo: newStackIdentifier))
    }
    
    func test_newStack_To_Go () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)!
        let to = newStack.to(viewControllerToGo: Start_NEW_STACK_SAME_StoryboardViewController.self)
        to.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Start_NEW_STACK_SAME_StoryboardViewController },
            evaluatedWith: newStack.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_newStack_To_Go_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack.to(viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        to.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Finish_TO_GO_SAME_StoryboardViewController },
            evaluatedWith: newStack.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_newStack_To_Go_AnotherStoryboard () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        let to = newStack.to(viewControllerToGo: Start_NEW_STACK_ANOTHER_StoryboardViewController.self)
        to.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Start_NEW_STACK_ANOTHER_StoryboardViewController },
            evaluatedWith: newStack.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_newStack_To_Go_AnotherStoryboard_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack.to(viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        to.go()
        
        _ = expectation(
            for: sut.predicate{ $0 is Start_TO_GO_ANOTHER_StoryboardViewController },
            evaluatedWith: newStack.navigationController,
            handler: .none
        )
               
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func test_newStack_To_Prepare_Go () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)!
        let to = newStack.to(viewControllerToGo: Start_NEW_STACK_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to.go()
        
        let viewController = newStack.navigationController.topViewController as? Start_NEW_STACK_SAME_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_To_Prepare_Go_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack.to(viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to.go()
        
        let viewController = newStack.navigationController.topViewController as? Finish_TO_GO_SAME_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_To_Prepare_Go_AnotherStoryboard () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        let to = newStack.to(viewControllerToGo: Start_NEW_STACK_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to.go()
        
        let viewController = newStack.navigationController.topViewController as? Start_NEW_STACK_ANOTHER_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
    }
    
    func test_newStack_To_Prepare_Go_AnotherStoryboard_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)!
        //ViewController is not TopViewController (Internal will clear old stack and init new stack with this viewController)
        let to = newStack.to(viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self) {
            XCTAssertEqual(false, $0?.receivedData)
            $0?.receivedData = true
        }
        to.go()
        
        let viewController = newStack.navigationController.topViewController as? Start_TO_GO_ANOTHER_StoryboardViewController
        XCTAssertNotNil(viewController)
        XCTAssertEqual(true, viewController!.receivedData)
        
    }
    
    func test_newStack_ToGo () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)
        let to = newStack?.toGo()
        XCTAssertEqual(true, to?.navigationController.topViewController is Start_NEW_STACK_SAME_StoryboardViewController)
    }
    
    func test_newStack_ToGo_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackIdentifier)
        let to = newStack?.toGo(viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Finish_TO_GO_SAME_StoryboardViewController)
    }
    
    func test_newStack_ToGo_AnotherStoryboard () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)
        let to = newStack?.toGo(viewControllerToGo: Start_NEW_STACK_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Start_NEW_STACK_ANOTHER_StoryboardViewController)
    }
    
    func test_newStack_ToGo_AnotherStoryboard_NewViewController () {
        let newStack = self.navigate.newStack(navControllerToGo: newStackAnotherStoryboardIdentifier, anotherStoryboard)
        let to = newStack?.toGo(viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self)
        XCTAssertEqual(true, to?.navigationController.topViewController is Start_TO_GO_ANOTHER_StoryboardViewController)
    }
    
    func test_newStackToGo () {
        let newStack = self.navigate.newStackToGo(newStackIdentifier)
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_NEW_STACK_SAME_StoryboardViewController)
    }
    
    func test_newStackToGo_AnotherStoryboard () {
        let newStack = self.navigate.newStackToGo(newStackAnotherStoryboardIdentifier, anotherStoryboard)
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_NEW_STACK_ANOTHER_StoryboardViewController)
    }
    
    func test_newStackToGo_AnotherStoryboard_NewViewController () {
        let newStack = self.navigate.newStackToGo(
            newStackAnotherStoryboardIdentifier,
            anotherStoryboard,
            viewControllerToGo: Start_TO_GO_ANOTHER_StoryboardViewController.self
        )
        XCTAssertEqual(true, newStack?.navigationController.topViewController is Start_TO_GO_ANOTHER_StoryboardViewController)
    }
    
}
