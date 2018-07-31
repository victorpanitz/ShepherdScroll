//
//  DemoViewController.swift
//  ShepherdScroll
//
//  Created by Victor Panitz Magalhães on 30/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import UIKit
import ShepherdScroll

class DemoMainViewController: UIViewController, Animatable {

    private var scrollView: ShepherdScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShepherdScroll()
//        setupConstraints()
    }
    
    private func setupShepherdScroll() {
        scrollView.setup(
            controller: self,
            viewControllers: [DemoAViewController(), DemoBViewController(), DemoCViewController()],
            size: view.frame.size,
            viewToAnimate: .next,
            orientation: .vertical,
            offset: 0.0)
        
//        guard let `scrollView` = scrollView else { return }
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func animate(step: CGFloat) {}
    
    private func setupConstraints() {
        guard let `scrollView` = scrollView else { return }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
}
