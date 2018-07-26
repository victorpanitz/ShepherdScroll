import Foundation
import UIKit

public enum ViewToAnimate {
    case current, next
}

public enum Orientation {
    case vertical, horizontal
}

public class ShepherdScrollView: UIScrollView {
    
    private lazy var viewControllers = [BaseAnimatedViewController]()
    private lazy var size = CGSize()
    private lazy var controller = UIViewController()
    private lazy var viewToAnimate = ViewToAnimate.current
    private lazy var orientation = Orientation.horizontal
    private lazy var offset: CGFloat = 0.0
    
    public init(controller:UIViewController, viewControllers: [BaseAnimatedViewController], size: CGSize, viewToAnimate: ViewToAnimate = .current, orientation: Orientation = .horizontal, offset: CGFloat = 0.0) {
        super.init(frame: .zero)
        self.viewControllers = viewControllers
        self.size = size
        self.controller = controller
        self.viewToAnimate = viewToAnimate
        self.orientation = orientation
        self.offset = offset
        
        setupParameters()
        setupViews()
        setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupParameters() {
        delegate = self
        isPagingEnabled = true
        bounces = false
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        orientation == .horizontal ?
            contentSize = CGSize(width: (size.width * CGFloat(viewControllers.count)) - (offset*size.width), height: size.height) :
           (contentSize = CGSize(width: size.width, height: (size.height * CGFloat(viewControllers.count)) - (offset*size.height)))
    }
    
    private func setupViews() {
        viewControllers.forEach { addViewController($0) }
    }
    
    private func addViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewController.view)
        controller.addChildViewController(viewController)
        viewController.didMove(toParentViewController: controller)
    }
    
    private func setupConstraints() {
        for (pos, viewController) in viewControllers.enumerated() {
            orientation == .horizontal ?
                constraintHorizontally(viewController, pos: pos) :
                constraintVertically(viewController, pos: pos)
            }
    }
    
    private func constraintHorizontally(_ viewController: BaseAnimatedViewController, pos: Int) {
        addViewController(viewController)
        let multiplier = pos == 0 ? CGFloat(1-offset) : CGFloat(1.0)
        let anchor = pos == 0 ? leadingAnchor : viewControllers[pos-1].view.trailingAnchor
        NSLayoutConstraint.activate([
            viewController.view.heightAnchor.constraint(equalToConstant: size.height),
            viewController.view.widthAnchor.constraint(equalToConstant: size.width * multiplier),
            viewController.view.leadingAnchor.constraint(greaterThanOrEqualTo: anchor)
            ])
    }
    
    private func constraintVertically(_ viewController: BaseAnimatedViewController, pos: Int) {
        addViewController(viewController)
    
        let multiplier = pos == 0 ? CGFloat(1-offset) : CGFloat(1.0)
        let anchor = pos == 0 ? topAnchor : viewControllers[pos-1].view.bottomAnchor
        NSLayoutConstraint.activate([
            viewController.view.heightAnchor.constraint(equalToConstant: size.height * multiplier),
            viewController.view.widthAnchor.constraint(equalToConstant: size.width),
            viewController.view.topAnchor.constraint(greaterThanOrEqualTo: anchor)
            ])
    }
    
    private func currentPos() -> Int {
        if orientation == .vertical { return Int(contentOffset.y/size.height) }
        else { return Int(contentOffset.x/size.width) }
    }
}

extension ShepherdScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if contentOffset.y < 0 || contentOffset.x < 0 { setContentOffset(.zero, animated: false) }
        guard (currentPos() + 1) < viewControllers.count else { return }
        animate(viewToAnimate, to: animationStep())
    }
    
    private func animate
        (_ view: ViewToAnimate , to step: CGFloat) {
        view == .current ?
            viewControllers[currentPos()].animate(step: step) :
            viewControllers[currentPos()+1].animate(step: step)
    }
    
    private func animationStep() -> CGFloat {
        if orientation == .vertical { return verticalStep() }
        else { return horizontalStep() }
    }
    
    private func verticalStep() -> CGFloat {
        let height = size.height
        return (contentOffset.y - (CGFloat(currentPos()) * height))/height
    }
    
    private func horizontalStep() -> CGFloat {
        let width = size.width
        return (contentOffset.x - (CGFloat(currentPos()) * width))/width
    }
}
