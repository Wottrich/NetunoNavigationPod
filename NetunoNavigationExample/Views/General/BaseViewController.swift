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

    lazy var navigate: Navigator = {
        return Navigator(navigationController: self.navigationController, rootViewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

