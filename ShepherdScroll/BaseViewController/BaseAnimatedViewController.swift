//
//  BaseAnimatedViewController.swift
//  SheperdScroll
//
//  Created by Victor Panitz Magalhães on 26/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import UIKit

open class BaseAnimatedViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    // step = 0...1
    open func animate(step: CGFloat) {}
    
}
