//
//  UINavigationControllerExtension.swift
//  NetunoNavigation
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

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
