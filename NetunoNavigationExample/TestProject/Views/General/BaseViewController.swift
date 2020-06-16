//
//  ViewController.swift
//  NavigatorExample
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import NetunoNavigation

class BaseViewController: UIViewController {

    var navigate: Navigator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigate = try? Navigator(navigationController: self.navigationController)
    }


}

