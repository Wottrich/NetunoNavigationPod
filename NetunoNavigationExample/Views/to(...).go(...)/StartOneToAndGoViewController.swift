//
//  StartOneToAndGoViewController.swift
//  NetunoNavigationExample
//
//  Created by Wottrich on 21/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class StartOneToAndGoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func didTapNextViewControllerWithoutPrepareOnCurrentStoryboard(_ sender: Any?) {
        self.navigate.to(
            self,
            viewControllerToGo: FinishOneToAndGoViewController.self
        ).go()
    }

}
