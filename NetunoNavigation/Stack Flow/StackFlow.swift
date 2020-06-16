//
//  StackFlow.swift
//  NetunoNavigation
//
//  Created by Wottrich on 15/06/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit
import Foundation

enum SFError: Error {
    case invalidArguments(message: String)
}

public class ViewControllerWrapper {
    
    var rootIdentifier: String
    var viewController: UIViewController.Type
    
    init(rootIdentifier: String, viewController: UIViewController.Type) {
        self.rootIdentifier = rootIdentifier
        self.viewController = viewController
    }
    
}

public class StackWrapper {
    
    var id: String = ""
    public var viewControllers: [ViewControllerWrapper] = []
    var rootViewController: UIViewController?
    
    //Viewcontroller that is visible in stack
    public var currentViewControllerType: UIViewController.Type?
    public var currentViewController: UIViewController?
    
    var indexCurrentViewController: Int? {
        get {
            guard let currentViewControllerType = self.currentViewControllerType else {return nil}
            return viewControllers.firstIndex { (wrapper) -> Bool in
                return wrapper.viewController === currentViewControllerType
            }
        }
    }
    
    init(_ id: String, _ viewControllers: [ViewControllerWrapper], _ rootViewController: UIViewController?) {
        self.id = id
        self.viewControllers = viewControllers
        self.rootViewController = rootViewController
        self.currentViewControllerType = rootViewController?.classForCoder as? UIViewController.Type
        self.currentViewController = rootViewController
    }
    
}

protocol StackFlowProtocol {
    
//    var navigationController: UINavigationController {get set}
//
//    var stacks: [StackWrapper] { get set }
//    var identifierInternal: String? { get set }
//    var currentViewController: UIViewController? { get set }
//
//    func start(_ identifier: String,  newStack: [UIViewController])
//
//    func next() -> Bool
//    func previous()
    
}

public class StackFlow: StackFlowProtocol {
    typealias SF = StackFlow
    public static var stacks: [StackWrapper] = []
    public static var stackID: String?
    
    var viewControllerToGo: UIViewController?
    
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController?) throws {
        if let nav = navigationController {
            self.navigationController = nav
        } else {
            throw SFError.invalidArguments(message: "UINavigationController must not be null")
        }
        
    }
    
    internal func validStack (stackID: String) -> Bool {
        
        let currentViewController = navigationController.viewControllers.last
        
        let stacks = SF.stacks.filter({ $0.id == stackID })
        
        if !stacks.isEmpty {
            return stacks.filter({ $0.rootViewController === currentViewController }).isEmpty
        }
        
        return true
    }
    
    public func start(_ stackID: String, newStack: [UIViewController.Type]) throws {
        
        //Validing if don't have an stack with same id and root viewcontroller
        if !validStack(stackID: stackID) {
            throw SFError.invalidArguments(message: "You cannot create a stack with same id and root")
        }
        
        //Validing if navigationController have viewControllers
        guard let rootViewController = navigationController.viewControllers.last, let clazz = rootViewController.classForCoder as? UIViewController.Type
            else { throw SFError.invalidArguments(message: "UINavigationController must have viewControllers") }
        
        //Getting stackID
        StackFlow.stackID = stackID
        
        //Init viewControllers with ViewControllerWrapper
        var viewControllers: [ViewControllerWrapper] = []
        //Adding rootViewController in stack as first viewController
        viewControllers.append(ViewControllerWrapper(rootIdentifier: stackID, viewController: clazz))
        //Adding viewControllers
        newStack.forEach {
            viewControllers.append(ViewControllerWrapper(rootIdentifier: stackID, viewController: $0))
        }
        
        //Appending in stacks
        StackFlow.stacks.append(StackWrapper(stackID, viewControllers, rootViewController))
        
    }
    
    public func setupStackID(stackID: String) {
        StackFlow.stackID = stackID
    }
    
    public func toPrepare<T:UIViewController>(type: T.Type, prepare: (T?) -> Void) -> StackFlowGo? {
        
        guard let findStack = StackFlow.stacks.first(where: { $0.id == StackFlow.stackID }) else {return nil}
        guard let rootViewController = findStack.rootViewController else {return nil}
        guard let index = findStack.indexCurrentViewController else {return nil}
        
        let nextIndex = index + 1
        
        if nextIndex == findStack.viewControllers.count {
            return nil
        } else {
            let nextViewControllerType = findStack.viewControllers[nextIndex].viewController
            
            if type !== nextViewControllerType {
                return nil
            }
            
            viewControllerToGo = T.storyboardInstance(currentViewController: rootViewController) as? T
            prepare(viewControllerToGo as? T)
            
            return StackFlowGo(navigationController: self.navigationController, viewController: viewControllerToGo, stackFlow: self)
        }
        
        
    }
    
    @discardableResult
    public func next() -> Bool {
        guard let findStack = StackFlow.stacks.first(where: { $0.id == StackFlow.stackID }) else {return false}
        guard let index = findStack.indexCurrentViewController else {return false}
        
        let nextIndex = index + 1
        
        if nextIndex == findStack.viewControllers.count {
            return false
        } else {
            return go(stackWrapper: findStack, index: nextIndex)
        }
    }
    
    @discardableResult
    private func go (stackWrapper: StackWrapper, index: Int, go: Bool = true) -> Bool {
        let viewControllerType = stackWrapper.viewControllers[index].viewController
        stackWrapper.currentViewControllerType = viewControllerType
        
        if go {
            
            guard let currenctViewController = stackWrapper.currentViewController, let vcToGoType = stackWrapper.currentViewControllerType
                else {return false}
            
            guard let navigate = try? Navigator(navigationController: self.navigationController) else {return false}
            
            let to = navigate.to(currenctViewController, viewControllerToGo: vcToGoType)
            
            stackWrapper.currentViewController = to.viewController
            
            to.go()
            
        }
        
        StackFlow.updateAsync(stackWrapper: stackWrapper)
        
        return true
    }
    
    class func updateAsync (stackWrapper: StackWrapper) {
        
        DispatchQueue.main.async {
            var filterredStacks = StackFlow.stacks.filter({ $0.id != stackWrapper.id })
            filterredStacks.append(stackWrapper)
            StackFlow.stacks = filterredStacks
        }
        
    }
    
    public func previous() {
        
    }
    
}

public class StackFlowGo {
    
    internal var viewController: UIViewController?
    internal var navigationController: UINavigationController?
    internal var stackFlow: StackFlow
    
    init(navigationController: UINavigationController?, viewController: UIViewController?, stackFlow: StackFlow) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.stackFlow = stackFlow
    }
    
    @discardableResult
    public func next () -> Bool {
        guard let findStack = StackFlow.stacks.first(where: { $0.id == StackFlow.stackID }) else {return false}
        guard let index = findStack.indexCurrentViewController else {return false}
        
        let nextIndex = index + 1
        
        if nextIndex == findStack.viewControllers.count {
            return false
        } else {
            
            let viewControllerType = findStack.viewControllers[nextIndex].viewController
            findStack.currentViewControllerType = viewControllerType
            findStack.currentViewController = viewController
            
            guard let navigate = try? Navigator(navigationController: self.navigationController), let vc = viewController else {return false}
            navigate.default.pushViewController(vc, animated: true)
            
            StackFlow.updateAsync(stackWrapper: findStack)
            return true
        }
    }
    
}
