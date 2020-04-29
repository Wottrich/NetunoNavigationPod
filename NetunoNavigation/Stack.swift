//
//  Stack.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

/**
 The `Stack` class is used to create a new flow that usually start with a new `Storyboard` and new `UIViewController`
 This class is like a filter to not used a uncorrectly functions to start a new Stack,
 the important functions is from [Navigate](x-source-tag://NavigateClass) class.
 */
public class Stack {
    
    var actualNavigationController: UINavigationController
    var navigationController: UINavigationController
    var viewController: UIViewController?
    
    private lazy var stackGo: StackGo = {
        StackGo(actualNavigationController: self.actualNavigationController, navigationController: self.navigationController)
    }()
    
    init (actualNavigationController: UINavigationController, navigationController: UINavigationController) {
        self.actualNavigationController = actualNavigationController
        self.navigationController = navigationController
    }
    
    public func to<T: UIViewController> (
        viewControllerToGo: T.Type,
        prepare: ((T?) -> Void)? = nil
    ) -> StackGo {
        
        if let firstViewController = self.navigationController.viewControllers.first, let tType = firstViewController as? T {
            
            prepare?(tType)
        
            return stackGo
        } else {
            viewController = T.storyboardInstance(currentViewController: self.navigationController) as? T
            prepare?(viewController as? T)
            
            if let viewController = self.viewController {
                self.navigationController.viewControllers.removeAll()
                self.navigationController.viewControllers.append(viewController)
            }
            
            return stackGo
        }
        
    }
    
    public func toGo<T: UIViewController> (
        viewControllerToGo: T.Type? = nil,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        if viewControllerToGo == nil {
            stackGo.go(animated: animated, completion)
        } else if let firstViewController = self.navigationController.viewControllers.first, firstViewController is T {
            stackGo.go(animated: animated, completion)
        } else {
            viewController = T.storyboardInstance(currentViewController: self.navigationController) as? T
            
            if let viewController = self.viewController {
                self.navigationController.viewControllers.removeAll()
                self.navigationController.viewControllers.append(viewController)
            }
            
            stackGo.go(modalPresentationStyle: modalPresentationStyle,animated: animated, completion)
            
        }
        
    }
    
}

/**
 `StackGo` class is used like a filter to not used a uncorrectly functions to start a new Stack,
 */
public class StackGo {
    
    var actualNavigationController: UINavigationController
    var navigationController: UINavigationController
    
    init (actualNavigationController: UINavigationController, navigationController: UINavigationController) {
        self.actualNavigationController = actualNavigationController
        self.navigationController = navigationController
    }
    
    public func go (
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        _ completion: (() -> Void)? = nil
    ) {
        
        self.navigationController.modalPresentationStyle = modalPresentationStyle
        
        self.actualNavigationController.present(self.navigationController, animated: animated, completion: completion)
        
    }
    
}
