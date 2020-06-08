//
//  NavigatorDefault.swift
//  NetunoNavigation
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

protocol NavigatorDefaultProtocol {
    
    func show(_ vc: UIViewController, sender: Any?)
    func showDetailViewController(_ vc: UIViewController, sender: Any?)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    
}

public class NavigatorDefault: NavigatorDefaultProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func show(_ vc: UIViewController, sender: Any?) {
        self.navigationController?.show(vc, sender: sender)
    }
    
    public func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        self.navigationController?.showDetailViewController(vc, sender: sender)
    }
    
    public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.navigationController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
}
