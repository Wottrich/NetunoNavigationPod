//
//  Go.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

/**
 `Go` is used to choose how your screen be saw
 */
public class Go {
    
    static var defaultAnimated: Bool = true 
    
    /**
     `navigationController` used to open a new ViewController
     */
    var navigationController: UINavigationController?
    
    /**
     `viewController` is the new view controller to go
     */
    var viewController: UIViewController?
    
    init(_ navigationController: UINavigationController?, _ viewController: UIViewController?) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    /**
     When we came by navigate `go` only can use on specific rules.
     
     Usually used when we need to put something at next ViewController.
     
     When we don't need to put something this function isn't returned and is called automatically.
     
     - parameters:
        - segue: Segue is how your screen is called, default value is .push. Another value in [Segue](x-source-tag://SegueClass) class.
        - animated: To know if screen need be called animated or not
        - completion: When processing to initialize screen is completed, this function is called
     */
    /// - Tag: GoClass
    public func go(segue: Segue = .push)  {
        
        guard let viewController = self.viewController, let nav = self.navigationController else {
            return
        }
        
        switch segue {
        case let .show(sender):
            nav.show(viewController, sender: sender)
        case let .showDetail(sender):
            nav.showDetailViewController(viewController, sender: sender)
        case let .presentModally(removeBackground, transitionStyle, animated, completion):
            if removeBackground {
                viewController.modalPresentationStyle = .overCurrentContext
            } else {
                viewController.modalPresentationStyle = .custom
            }
            
            viewController.modalTransitionStyle = transitionStyle
            nav.present(viewController, animated: animated ?? true, completion: completion)
        case let .presentAsPopover(animated, completion):
            nav.modalPresentationStyle = .popover
            nav.present(viewController, animated: animated ?? true, completion: completion)
        case .root:
            self.setAsRootViewController(viewController)
        case let .push(animated):
            nav.pushViewController(viewController, animated: animated ?? true)
        case let .modal(modalPresentationStyle, animated, completion):
            viewController.modalPresentationStyle = modalPresentationStyle
            nav.present(viewController, animated: animated ?? true, completion: completion)
        }
        
    }
    
    /**
     Used to set RootViewController on Window with transition
     
     - parameters:
        - viewController: ViewController to be new RootViewController
     */
    private func setAsRootViewController (_ viewController: UIViewController) {
        if #available(iOS 13, *) {
            
            guard let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first else {return}
            
            let navController = UINavigationController(rootViewController: viewController)
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = navController
            }, completion: nil)
            
        } else {
            
            guard let window = UIApplication.shared.keyWindow else {return}
            
            let navController = UINavigationController(rootViewController: viewController)
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = navController
            }, completion: nil)
            
        }
    }
    
}

