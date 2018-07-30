//
//  DemoAViewController.swift
//  ShepherdScroll
//
//  Created by Victor Panitz Magalhães on 30/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import UIKit
import ShepherdScroll

class DemoAViewController: UIViewController, Animatable {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "DRAG UP"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setupLayout()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func animate(step: CGFloat) {}
    
    private func setupLayout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.4),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
    }
}
