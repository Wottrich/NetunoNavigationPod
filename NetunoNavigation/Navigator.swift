//
//  Navigator.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

/**
 
 */
/// - Tag: NavigateClass
public class Navigator: NavigatorProtocol {
    
    
    //Public
    public var viewController: UIViewController?
    public var navigationController: UINavigationController?
    public var `default`: NavigatorDefault {
        get {
            return NavigatorDefault(navigationController: self.navigationController)
        }
    }
    
    var stackFlowInternal: StackFlow
    
    public var stackFlow: StackFlow {
        get {
            return stackFlowInternal
        }
    }
    
    public init (navigationController nav: UINavigationController?) throws {
        self.navigationController = nav
        
        do {
            stackFlowInternal = try StackFlow(navigationController: nav)
        } catch let error {
            throw error
        }
    }
    
    // MARK: - to()
    public func to<T: UIViewController>(
        _ currentViewController: UIViewController,
        viewControllerToGo _: T.Type,
        prepare: ((T?) -> Void)? = nil
    ) -> Go {
        viewController = T.storyboardInstance(currentViewController: currentViewController) as? T
        prepare?(viewController as? T)
        
        return Go(self.navigationController, viewController)
    }
    
    public func to<T: UIViewController> (
        _ storyboardToGo: String,
        viewControllerToGo: T.Type,
        prepare: ((T?) -> Void)? = nil
    ) -> Go {
        viewController = T.storyboardInstance(storyboardName: storyboardToGo) as? T
        prepare?(viewController as? T)
        
        return Go(self.navigationController, viewController)
    }
    
    // MARK: - toGo()
    @discardableResult
    public func toGo<T: UIViewController> (
        _ currentViewController: UIViewController,
        viewControllerToGo: T.Type,
        segue: Segue = .push(animated: Go.defaultAnimated)
    ) -> Bool {
        viewController = T.storyboardInstance(currentViewController: currentViewController) as? T
        
        return Go(self.navigationController, viewController).go(segue: segue)
    }
    
    @discardableResult
    public func toGo<T: UIViewController> (
        _ storyboardToGo: String,
        viewControllerToGo: T.Type,
        segue: Segue = .push(animated: Go.defaultAnimated)
    ) -> Bool {
        viewController = T.storyboardInstance(storyboardName: storyboardToGo) as? T
        
        return Go(self.navigationController, viewController).go(segue: segue)
    }
    
    // MARK: - newStack()
    public func newStack (
        navControllerToGo: String,
        _ storyboardToGo: String? = nil
    ) -> Stack? {
        
        guard let actualNavController = self.navigationController else {return nil}
        
        if let storyboardName = storyboardToGo {
            
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: storyboardName)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            return Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            
        } else {
            
            guard let storyboard = actualNavController.storyboard else {return nil}
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: storyboard)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            return Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            
        }
        
    }
    
    public func newStackToGo<T: UIViewController> (
        _ navControllerToGo: String,
        _ storyboardToGo: String? = nil,
        viewControllerToGo: T.Type? = nil,
        style: ModalStyleEnum = .none
    ) -> Stack? {
        
        guard let actualNavController = self.navigationController else {return nil}
        
        if let storyboardName = storyboardToGo {
            
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: storyboardName)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            let stack = Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            return stack.toGo(viewControllerToGo, style: style)
            
        } else {
            
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: self.navigationController?.storyboard)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            let stack = Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            return stack.toGo(viewControllerToGo, style: style)
            
        }
        
    }
}
