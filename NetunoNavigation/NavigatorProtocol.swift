//
//  NavigatorProtocol.swift
//  NetunoNavigation
//
//  Created by Wottrich on 24/05/20.
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
    ) -> Stack?
    
}
