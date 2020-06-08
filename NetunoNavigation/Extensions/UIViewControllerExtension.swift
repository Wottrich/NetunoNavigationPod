//
//  UIViewControllerExtension.swift
//  NetunoNavigation
//
//  Created by Wottrich on 24/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    public class func storyboardInstance(storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    public class func storyboardInstance(currentViewController: UIViewController) -> UIViewController? {
        return currentViewController.storyboard?.instantiateViewController(withIdentifier: identifier)
    }
    
    class func instantiate(identifier: String, storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    class func instantiate (identifier: String, storyboard: UIStoryboard?) -> UIViewController? {
        return storyboard?.instantiateViewController(withIdentifier: identifier)
    }
    
}
