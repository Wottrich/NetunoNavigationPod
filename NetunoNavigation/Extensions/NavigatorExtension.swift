//
//  NavigatorExtension.swift
//  NetunoNavigation
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension Navigator {
    
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
