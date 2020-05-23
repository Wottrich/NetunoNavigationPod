//
//  StartOneToAndGoViewController.swift
//  NetunoNavigationExample
//
//  Created by Wottrich on 21/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class Start_TO_GO_SAME_StoryboardViewController: BaseViewController {

    public static let rootNavigationControllerIdentifier = "InitNavigationControllerSameStoryboard"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func didTapNextViewControllerWithoutPrepareOnCurrentStoryboard(_ sender: Any?) {
        self.navigate.to(
            self,
            viewControllerToGo: Finish_TO_GO_SAME_StoryboardViewController.self
        ).go()
    }

}
