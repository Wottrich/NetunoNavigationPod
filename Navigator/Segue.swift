//
//  Segue.swift
//  Navigator
//
//  Created by Wottrich on 21/04/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit


/**
 Segue is an enum with some type to see/show
 
 Is used to help [Go](x-source-tag://GoClass)
 
 */
/// - Tag: SegueClass
public enum Segue {
    case show(sender: Any?)
    case showDetail(sender: Any?)
    case presentModally(removeBackground: Bool, transitionStyle: UIModalTransitionStyle)
    case presentAsPopover
    case root
    //deprecated in iOS
    case push
    case modal(modalPresentationStyle: UIModalPresentationStyle)
}

