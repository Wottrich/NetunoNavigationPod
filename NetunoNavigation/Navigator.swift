//
//  Navigator.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

public protocol NavigatorProtocol {
    
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
    
    @discardableResult
    func toGo<T: UIViewController> (
        _ currentViewController: UIViewController,
        viewControllerToGo: T.Type,
        segue: Segue
    ) -> Bool
    
    @discardableResult
    func toGo<T: UIViewController> (
        _ storyboardToGo: String,
        viewControllerToGo: T.Type,
        segue: Segue
    ) -> Bool
    
    func newStack (
        navControllerToGo: String,
        _ storyboardToGo: String?
    ) -> Stack?
    
    func newStackToGo<T: UIViewController> (
        _ navControllerToGo: String,
        _ storyboardToGo: String?,
        viewControllerToGo: T.Type?,
        modalPresentationStyle: UIModalPresentationStyle,
        animated: Bool,
        _ completion: (() -> Void)?
    )
    
}

/**
 
 */
/// - Tag: NavigateClass
public class Navigator: NavigatorProtocol {
    
    
    //Public
    public var viewController: UIViewController?
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
        
        if let storyboardName = storyboardToGo {
            
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: storyboardName)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            return self.navigationController != nil
                ? Stack(actualNavigationController: self.navigationController!, navigationController: newNavigationController)
                : nil
        } else {
            let instantiateViewController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: self.navigationController?.storyboard)
            guard let newNavigationController = instantiateViewController as? UINavigationController else {return nil}
            
            return self.navigationController != nil
                ? Stack(actualNavigationController: self.navigationController!, navigationController: newNavigationController)
                : nil
        }
        
    }
    
    public func newStackToGo<T: UIViewController> (
        _ navControllerToGo: String,
        _ storyboardToGo: String? = nil,
        viewControllerToGo: T.Type? = nil,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = false,
        _ completion: (() -> Void)? = nil
    ) {
        
        if let storyboardName = storyboardToGo {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: storyboardName)
                as? UINavigationController else {return}
            
            if let actualNavController = self.navigationController {
                
                Stack(actualNavigationController: actualNavController, navigationController: newNavigationController)
                    .toGo(viewControllerToGo: viewControllerToGo, modalPresentationStyle: modalPresentationStyle, animated: animated, completion: completion)
                
            }
            
        } else {
            
            guard let newNavigationController = UINavigationController.instantiate(identifier: navControllerToGo, storyboard: self.navigationController?.storyboard)
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
