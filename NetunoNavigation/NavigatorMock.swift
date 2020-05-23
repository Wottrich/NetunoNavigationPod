//
//  NavigatorMock.swift
//  NetunoNavigation
//
//  Created by Wottrich on 21/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

public class NavigatorMock {
    
    public var storyboard: UIStoryboard!
    public var window: UIWindow?
    public var navigationController: UINavigationController!
    public var anotherNavController: UINavigationController!
    public var currentViewController: UIViewController? {
        get {
            return navigationController.topViewController
        }
    }
    
    public convenience init(window: UIWindow?, storyboard: UIStoryboard, initNavController: String, anotherNavController: String, viewControllersType: [UIViewController.Type]) {
        
        let navigationController = storyboard.instantiateViewController(identifier: initNavController) as UINavigationController
        
        var viewControllers: [UIViewController] = []
        
        for type in viewControllersType {
            let viewController = storyboard.instantiateViewController(identifier: type.identifier)
            viewControllers.append(viewController)
        }
        
        navigationController.viewControllers = viewControllers
        
        self.init(window: window, storyboard: storyboard, anotherNavController: anotherNavController, navigationController: navigationController)
    }
    
    public init (window: UIWindow?, storyboard: UIStoryboard, anotherNavController: String, navigationController: UINavigationController) {
        self.window = window
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.anotherNavController = storyboard.instantiateViewController(identifier: anotherNavController)
    }
    
    public func validTopViewController<T: UIViewController> (type _: T.Type) -> Bool {
        return self.navigationController.topViewController is T
    }
    
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
    
}
