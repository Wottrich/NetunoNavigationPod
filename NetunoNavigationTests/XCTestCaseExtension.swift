//
//  XCTestCaseExtension.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import XCTest
import UIKit

extension XCTestCase {
    
    public func predicate (_ expression: @escaping (UIViewController?) -> Bool) -> NSPredicate {
        return NSPredicate { input, _ in
            if let navController = input as? UINavigationController {
                return expression(navController.topViewController)
            } else if let mWindow = input as? UIWindow {
                return expression(mWindow.rootViewController)
            }
            
            return expression(nil)
        }
    }
    
    func myEspectation(_ expression: @escaping (UIViewController?) -> Bool, _ evaluatedWith: Any?) -> XCTestExpectation {
        return expectation(for: self.predicate{ expression($0) }, evaluatedWith: evaluatedWith)
    }
    
}
