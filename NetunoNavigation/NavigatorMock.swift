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
    public var navigationController: UINavigationController!
    public var currentViewController: UIViewController? {
        get {
            return navigationController.topViewController
        }
    }
    
    public convenience init(storyboardName: String, bundle: Bundle?, viewControllersType: [UIViewController.Type]) {
        
        let navigationController = UINavigationController()
        let storyboard = UIStoryboard(name: "ToAndGoStoryboard", bundle: nil)
        var viewControllers: [UIViewController] = []
        
        for type in viewControllersType {
            let viewController = storyboard.instantiateViewController(identifier: type.identifier)
            viewControllers.append(viewController)
        }
        
        navigationController.viewControllers = viewControllers
        
        self.init(storyboard: storyboard, navigationController: navigationController)
    }
    
    public init (storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    public func validTopViewController<T: UIViewController> (type _: T.Type) -> Bool {
        return self.navigationController.topViewController is T
    }
    
    public func predicate (_ expression: @escaping (UIViewController?) -> Bool) -> NSPredicate {
        return NSPredicate { input, _ in
            return expression((input as? UINavigationController)?.topViewController)
        }
    }
    
}
