//
//  SheperdScrollTests.swift
//  SheperdScrollTests
//
//  Created by Victor Panitz Magalhães on 26/07/2018.
//  Copyright © 2018 Victor Panitz Magalhães. All rights reserved.
//

import XCTest
@testable import ShepherdScroll

class SheperdScrollTests: XCTestCase {

    private var scrollView: ShepherdScrollView?
    
    override func setUp() {
        super.setUp()
        
        scrollView = ShepherdScrollView(
            controller: UIViewController(),
            viewControllers: [supportViewController(), supportViewController(), supportViewController()],
            size: CGSize(width: 375, height: 667),
            viewToAnimate: .current,
            orientation: randomBool() ? .vertical : .horizontal,
            offset: 0)
    }
    
    func testCurrentPos() {
        guard let `scrollView` = scrollView else { return }
        
        if scrollView.orientation == .vertical {
            scrollView.contentOffset.y = 800
            XCTAssert(scrollView.currentPosition == 1, "Not returning the correct position based on the current state")
        } else {
            scrollView.contentOffset.x = 400
            print(scrollView.currentPosition)
            XCTAssert(scrollView.currentPosition == 1, "Not returning the correct position based on the current state")
        }
    }
    
    func testVerticalStep() {
        guard let `scrollView` = scrollView else { return }
        
        if scrollView.orientation == .vertical {
            scrollView.contentOffset.y = 900
            XCTAssert(round(1000*scrollView.verticalStep())/1000 == 0.349, "Not returning the correct step value to the current state os parameters")
        } else {
            print("TEST \(round(1000*scrollView.verticalStep()))")

            XCTAssert(round(1000*scrollView.verticalStep())/1000 == 0, "Not returning the correct step value to the current state os parameters")
        }
    }
    
    func testHorizontalStep() {
        guard let `scrollView` = scrollView else { return }

        if scrollView.orientation == .horizontal {
            scrollView.contentOffset.x = 500
            XCTAssert(round(1000*scrollView.horizontalStep())/1000 == 0.333, "Not returning the correct step value to the current state os parameters")
        } else {
            print("TEST \(round(1000*scrollView.horizontalStep()))")

            XCTAssert(round(1000*scrollView.horizontalStep())/1000 == 0, "Not returning the correct step value to the current state os parameters")
        }
    }
    
    func testPerformanceExample() {
        self.measure { }
    }
}

extension SheperdScrollTests {
    func randomBool() -> Bool {
        return (arc4random_uniform(UInt32(2))) == 0
    }
}

class supportViewController: UIViewController, Animatable {
    func animate(step: CGFloat) {}
    override func viewDidLoad() {}
}


