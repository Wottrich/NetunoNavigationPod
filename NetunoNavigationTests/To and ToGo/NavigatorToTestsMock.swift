//
//  NavigatorToTestsMock.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import NetunoNavigation
import UIKit

class NavigatorToTestsMock {
    
    var navigate: Navigator
    var navigationController: UINavigationController?
    var currentViewController: UIViewController? {
        get {
            return navigationController?.topViewController
        }
    }
    
    init(storyboard: UIStoryboard, initNavControllerIdentifier: String) {
        self.navigationController = storyboard.instantiateViewController(withIdentifier: initNavControllerIdentifier) as? UINavigationController
        self.navigate = Navigator(navigationController: self.navigationController)
    }
    
}
