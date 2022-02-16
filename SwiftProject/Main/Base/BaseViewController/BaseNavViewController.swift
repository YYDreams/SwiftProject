//
//  BaseNavViewController.swift
//  XMHomeUI
//
//  Created by flowerflower on 2021/9/1.
//

import UIKit

open class BaseNavViewController: UINavigationController {
        
    //拦截侧滑返回事件
   public var navigationGestBlock:(()->Void)?

    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let interactionGes = interactivePopGestureRecognizer else { return }
        guard let targetView = interactionGes.view else { return }
        guard let internalTargets = interactionGes.value(forKeyPath: "targets") as? [NSObject] else { return }
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))

        let fullScreenGesture = UIPanGestureRecognizer(target: internalTarget, action: action)
        fullScreenGesture.delegate = self
        targetView.addGestureRecognizer(fullScreenGesture)
        interactionGes.isEnabled = false
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            interactivePopGestureRecognizer?.isEnabled = true
        }else{
            interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        if ges.translation(in: gestureRecognizer.view).x * (isLeftToRight ? 1 : -1) <= 0
            || disablePopGesture {
            return false
        }
        if self.navigationGestBlock != nil {
            self.navigationGestBlock!()
            return false
        }
        //如果isEnabled被置为不可用 则禁用侧滑返回
        if !(interactivePopGestureRecognizer?.isEnabled ?? false) {
            return false
        }
        return self.viewControllers.count > 1
    }
}

extension BaseNavViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}


enum UNavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController {
    
    private struct AssociatedKeys {
        static var disablePopGesture: Void?
    }
    
    var disablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

