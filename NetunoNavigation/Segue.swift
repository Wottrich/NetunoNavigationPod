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
    case presentModally(modalStyle: ModalStyleEnum)
    case presentAsPopover(animated: Bool?, completion: (() -> Void)?)
    case root
    //deprecated in iOS
    case push(animated: Bool?)
    case modal(modalStyle: ModalStyleEnum)
}

public enum ModalStyleEnum {
    case modal (modalTransitionStyle: UIModalTransitionStyle, modalPresentationStyle: UIModalPresentationStyle, animated: Bool, completion: (() -> Void)?)
    case `default` (animated: Bool, completion: (() -> Void)?)
    case none
    
    var modalTransitionStyle: UIModalTransitionStyle? {
        get {
            switch self {
            case .modal(let transitionStyle, _, _, _):
                return transitionStyle
            default:
                return nil
            }
        }
    }
    
    var modalPresentationStyle: UIModalPresentationStyle? {
        get {
            switch self {
            case .modal(_, let modalPresentationStyle, _, _):
                return modalPresentationStyle
            default:
                return nil
            }
        }
    }
    
    var animated: Bool {
        get {
            switch self {
            case .modal(_, _, let animated, _):
                return animated
            case .default(let animated, _):
                return animated
            case .none:
                return false
            }
        }
    }
    
    var completion: (() -> Void)? {
        get {
            switch self {
            case .modal(_, _, _, let completion):
                return completion
            case .default(_, let completion):
                return completion
            case .none:
                return nil
            }
        }
    }
}
