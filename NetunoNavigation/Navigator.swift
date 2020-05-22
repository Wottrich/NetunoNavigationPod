//
//  Navigator.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

protocol NavigatorProtocol {
    
    var navigationController: UINavigationController? { get set }
    var viewController: UIViewController? { get set }
    
    func to<T: UIViewController> (
        _ currentViewController: UIViewController,
        viewControllerToGo _: T.Type,
        prepare: ((T?) -> Void)?
    ) -> Go
    
    func to<T: UIViewController> (
        _ storyboardToGo: String,
        viewControllerToGo: T.Type,
        prepare: ((T?) -> Void)?
    ) -> Go
    
}

/**
 
 */
/// - Tag: NavigateClass
public class Navigator: NavigatorProtocol {
    
    //Internal
    internal var viewController: UIViewController?
    
    //Public
    public var navigationController: UINavigationController?
    
    public init (navigationController nav: UINavigationController?) {
        self.navigationController = nav
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
    public func toGo<T: UIViewController> (
        _ currentViewController: UIViewController,
        viewControllerToGo: T.Type,
        segue: Segue = .push(animated: Go.defaultAnimated)
    ) {
        
        viewController = T.storyboardInstance(currentViewController: currentViewController) as? T
        
        Go(
            self.navigationController,
            viewController
        ).go(segue: segue)
        
    }
    
    public func toGo<T: UIViewController> (
        _ storyboardToGo: String,
        viewControllerToGo: T.Type,
        segue: Segue = .push(animated: Go.defaultAnimated)
    ) {
        
        viewController = T.storyboardInstance(storyboardName: storyboardToGo) as? T
        
        Go(
            self.navigationController,
            viewController
        ).go(segue: segue)
        
    }
    
    // MARK: - newStack()
    public func newStack (
        _ navigationControllerToGo: String,
        _ storyboardToGo: String? = nil
    ) -> Stack? {
        
        if let storyboardName = storyboardToGo {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navigationControllerToGo, storyboard: storyboardName)
                as? UINavigationController else {return nil}
            
            if let actualNavController = self.navigationController {
                return Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            } else {
                return nil
            }
            
        } else {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navigationControllerToGo, storyboard: self.navigationController?.storyboard)
                as? UINavigationController else {return nil}
            
            if let actualNavController = self.navigationController {
                return Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
            } else {
                return nil
            }
            
        }
        
    }
    
    public func newStackToGo<T: UIViewController> (
        _ navigationControllerToGo: String,
        _ storyboardToGo: String? = nil,
        viewControllerToGo: T.Type? = nil,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = false,
        _ completion: (() -> Void)? = nil
    ) {
        
        if let storyboardName = storyboardToGo {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navigationControllerToGo, storyboard: storyboardName)
                as? UINavigationController else {return}
            
            if let actualNavController = self.navigationController {
                
                Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
                    .toGo(viewControllerToGo: viewControllerToGo, modalPresentationStyle: modalPresentationStyle, animated: animated, completion: completion)
                
            }
            
        } else {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navigationControllerToGo, storyboard: self.navigationController?.storyboard)
                as? UINavigationController else {return}
            
            if let actualNavController = self.navigationController {
                
                Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
                    .toGo(viewControllerToGo: viewControllerToGo, modalPresentationStyle: modalPresentationStyle, animated: animated, completion: completion)
                
            }
        }
    }
    
    // MARK: - popViewController ()
    
    public func popViewController (animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    public func popToRootViewController (animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    public func hasViewControllerInStack<T: UIViewController> (viewController: T.Type) -> Bool {
        if let nav = self.navigationController {
            return !nav.viewControllers.filter({$0 is T}).isEmpty
        }
        
        return false
        
    }
    
    public func popToViewController<T: UIViewController> (viewControllerToPop: T.Type) {
        self.navigationController?.popToViewController(viewController: viewControllerToPop)
    }
}

extension UINavigationController {
    
    public func popToViewController<T: UIViewController>(viewController: T.Type) {
        var viewControllerToPop: UIViewController?
        for controller in self.viewControllers {
            if controller.isKind(of: T.self) {
                viewControllerToPop = controller
                break
            }
        }
        if let controller = viewControllerToPop {
            self.popToViewController(controller, animated: true)
        }
    }
    
}

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    public class func storyboardInstance(storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    public class func storyboardInstance(currentViewController: UIViewController) -> UIViewController? {
        return currentViewController.storyboard?.instantiateViewController(withIdentifier: identifier)
    }
    
    class func instantiate(identifier: String, storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    class func instantiate (identifier: String, storyboard: UIStoryboard?) -> UIViewController? {
        return storyboard?.instantiateViewController(withIdentifier: identifier)
    }
    
}
