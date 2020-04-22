//
//  NavigatorController.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class NavigatorController: UINavigationController {

    static var backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static var detailColor = UIColor(red: 209/255, green: 184/255, blue: 95/255, alpha: 1)
    static var backArrowImage = UIImage(named: "chevron.left")
    static var titleFont = UIFont.systemFont(ofSize: 16.0)
    
     // MARK: - Life cycle

       override init(rootViewController: UIViewController) {
           super.init(rootViewController: rootViewController)
           setupNavigationBar()
       }

       override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
           super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
           setupNavigationBar()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setupNavigationBar()
       }

       // MARK: - View life cycle

       override func viewDidLoad() {
           super.viewDidLoad()
           setupNavigationBar()
       }

    private func setupNavigationBar() {
        navigationBar.backIndicatorImage = NavigatorController.backArrowImage
        
        navigationBar.backIndicatorTransitionMaskImage = NavigatorController.backArrowImage
        navigationBar.isTranslucent = false
        
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = NavigatorController.backgroundColor
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: NavigatorController.detailColor,
            NSAttributedString.Key.font: NavigatorController.titleFont
        ]
        
        navigationBar.titleTextAttributes = textAttributes
    }

}

