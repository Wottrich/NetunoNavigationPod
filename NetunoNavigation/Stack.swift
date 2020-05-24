//
//  Stack.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

public enum StackGoEnum {
    case go (modalPresentationStyle: UIModalPresentationStyle, animated: Bool, completion: (() -> Void)?)
    case go (animated: Bool, completion: (() -> Void)?)
}

/**
 The `Stack` class is used to create a new flow that usually start with a new `Storyboard` and new `UIViewController`
 This class is like a filter to not used a uncorrectly functions to start a new Stack,
 the important functions is from [Navigate](x-source-tag://NavigateClass) class.
 */
public class Stack {
    
    //Internal
    var actualNavigationController: UINavigationController
    var viewController: UIViewController?
    
    //Public
    public var navigationController: UINavigationController
    
    private var stackGo: StackGo {
        get {
            return StackGo(actualNavigationController: self.actualNavigationController, navigationController: self.navigationController)
        }
    }

    init (actualNavigationController: UINavigationController, navigationController: UINavigationController) {
        self.actualNavigationController = actualNavigationController
        self.navigationController = navigationController
    }
    
    public func to<T: UIViewController> (
        viewControllerToGo: T.Type,
        prepare: ((T?) -> Void)? = nil
    ) -> StackGo {
        
        if let viewController = self.navigationController.viewControllers.first as? T {
            prepare?(viewController)
        } else {
            viewController = T.storyboardInstance(currentViewController: self.navigationController) as? T
            prepare?(viewController as? T)
            
            if let viewController = self.viewController {
                self.navigationController.viewControllers.removeAll()
                self.navigationController.viewControllers.append(viewController)
            }
            
        }
        
        return stackGo
    }
    
    @discardableResult
    public func toGo<T: UIViewController> (
        _ viewControllerToGo: T.Type? = nil,
        go: StackGoEnum = .go(modalPresentationStyle: .fullScreen, animated: true, completion: nil)
    ) -> Stack {

        func goViewController (modalPresentationStyle: UIModalPresentationStyle?, animated: Bool, completion: (() -> Void)?) {

            if viewControllerToGo != nil && !(self.navigationController.viewControllers.first is T) {
                viewController = T.storyboardInstance(currentViewController: self.navigationController) as? T
                
                if let viewController = self.viewController {
                    self.navigationController.viewControllers.removeAll()
                    self.navigationController.viewControllers.append(viewController)
                }
                
            }
            
            stackGo.go(modalPresentationStyle: modalPresentationStyle, animated: animated, completion)
            
        }
        
        switch go {
        case let .go(modalPresentationStyle, animated, completion: ()):
            goViewController(modalPresetationStyle: modalPresentationStyle, animated: animated, completion: completion)
        case let .go(animated, completion):
            goViewController(modalPresentationStyle: nil, animated: animated, completion: completion)
        }
        
        return self
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
        modalPresentationStyle: UIModalPresentationStyle?:  = .fullScreen,
        animated: Bool = true,
        _ completion: (() -> Void)? = nil
    ) {
        
        self.navigationController.modalPresentationStyle = modalPresentationStyle
        
        self.actualNavigationController.present(self.navigationController, animated: animated, completion: completion)
        
    }
    
}
