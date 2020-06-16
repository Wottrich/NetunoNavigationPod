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
        do {
            self.navigate = try Navigator(navigationController: navigationController)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
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
    
    func test_stackFlow () {
        
        print("=========INIT===========")
        let sf = self.navigate.stackFlow

        try? sf.start("mynewstack", newStack: [Finish_TO_GO_SAME_StoryboardViewController.self])

        StackFlow.stacks.forEach { (stackWrapper) in
            print(stackWrapper.viewControllers)
            print(stackWrapper.currentViewController ?? "Deu ruim 1")
        }

        //Print
        //[NetunoNavigation.ViewControllerWrapper, NetunoNavigation.ViewControllerWrapper, NetunoNavigation.ViewControllerWrapper]
        //<NetunoNavigationExample.Start_TO_GO_SAME_StoryboardViewController: 0x7f8384f1ba70>
        
        let prepare = sf.toPrepare(type: Finish_TO_GO_SAME_StoryboardViewController.self) { (nextViewController) in
            nextViewController?.title = "Lucas"
        }
        
        XCTAssertNotNil(prepare)
        
        prepare?.next()

        StackFlow.stacks.forEach { (stackWrapper) in
            print(stackWrapper.viewControllers)
            print(stackWrapper.currentViewController ?? "Deu ruim 2")
            print(stackWrapper.currentViewController?.title ?? "Deu ruim 3")
        }
        
        //Print
        //[NetunoNavigation.ViewControllerWrapper, NetunoNavigation.ViewControllerWrapper, NetunoNavigation.ViewControllerWrapper]
        //<NetunoNavigationExample.Start_TO_GO_ANOTHER_StoryboardViewController: 0x7f8384f7dc60>
        print("=========FINISH===========")
        
    }
    
}
