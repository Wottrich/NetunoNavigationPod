//
//  NewStackTestsMock.swift
//  NetunoNavigationTests
//
//  Created by Wottrich on 25/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import NetunoNavigation

class NewStackTestsMock {
    
    var navigate: Navigator?
    var navigationController: UINavigationController?
    
    init(storyboard: UIStoryboard, navigationControllerIdentifier: String) {
        self.navigationController = storyboard.instantiateViewController(withIdentifier: navigationControllerIdentifier) as? UINavigationController
        self.navigate = try? Navigator(navigationController: self.navigationController)
    }
    
}
