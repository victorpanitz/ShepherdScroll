//
//  BaseAnimatedViewController.swift
//  SheperdScroll
//
//  Created by Victor Panitz Magalhães on 26/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import UIKit

public protocol Animatable: class {
    func animate(step: CGFloat)
    var viewController: UIViewController { get }
}

public extension Animatable where Self: UIViewController {
    var viewController: UIViewController { return self }
}


