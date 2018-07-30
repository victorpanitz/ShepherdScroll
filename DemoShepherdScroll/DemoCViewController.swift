//
//  DemoCViewController.swift
//  ShepherdScroll
//
//  Created by Victor Panitz Magalhães on 30/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import UIKit
import ShepherdScroll

class DemoCViewController: UIViewController, Animatable {

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "DRAG UP"
        label.alpha = 0.3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        setupLayout()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func animate(step: CGFloat) {
        label.alpha = 0.3 + (step*0.7)
        label.transform = CGAffineTransform(scaleX: 1 + step, y: 1 + step)
            .concatenating(CGAffineTransform(translationX: 0, y: 200 * step))
    }
    
    private func setupLayout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
    }
}
