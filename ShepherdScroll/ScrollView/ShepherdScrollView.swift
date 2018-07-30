import Foundation
import UIKit

public enum ViewToAnimate {
    case current, next
}

public enum Orientation {
    case vertical, horizontal
}

public protocol ShepherdScrollCustomDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public class ShepherdScrollView: UIScrollView {
    
    public lazy var animatableControllers = [Animatable]()
    public lazy var size = CGSize()
    public lazy var controller = UIViewController()
    public lazy var viewToAnimate = ViewToAnimate.current
    public lazy var orientation = Orientation.horizontal
    public lazy var offset: CGFloat = 0.0
    
    public weak var customDelegate: ShepherdScrollCustomDelegate?
    
    public init(controller:UIViewController, viewControllers: [Animatable], size: CGSize, viewToAnimate: ViewToAnimate = .current, orientation: Orientation = .horizontal, offset: CGFloat = 0.0) {
        super.init(frame: .zero)
        self.animatableControllers = viewControllers
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
            contentSize = CGSize(width: (size.width * CGFloat(animatableControllers.count)) - (offset*size.width), height: size.height) :
           (contentSize = CGSize(width: size.width, height: (size.height * CGFloat(animatableControllers.count)) - (offset*size.height)))
    }
    
    private func setupViews() {
        animatableControllers.forEach { addViewController($0.viewController) }
    }
    
    private func addViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewController.view)
        controller.addChildViewController(viewController)
        viewController.didMove(toParentViewController: controller)
    }
    
    private func setupConstraints() {
        for (pos, animatable) in animatableControllers.enumerated() {
            orientation == .horizontal ?
                constraintHorizontally(animatable.viewController, pos: pos) :
                constraintVertically(animatable.viewController, pos: pos)
            }
    }
    
    private func constraintHorizontally(_ viewController: UIViewController, pos: Int) {
        addViewController(viewController)
        let multiplier = pos == 0 ? CGFloat(1-offset) : CGFloat(1.0)
        let anchor = pos == 0 ? leadingAnchor : animatableControllers[pos-1].viewController.view.trailingAnchor
        NSLayoutConstraint.activate([
            viewController.view.heightAnchor.constraint(equalToConstant: size.height),
            viewController.view.widthAnchor.constraint(equalToConstant: size.width * multiplier),
            viewController.view.leadingAnchor.constraint(greaterThanOrEqualTo: anchor)
            ])
    }
    
    private func constraintVertically(_ viewController: UIViewController, pos: Int) {
        addViewController(viewController)
    
        let multiplier = pos == 0 ? CGFloat(1-offset) : CGFloat(1.0)
        let anchor = pos == 0 ? topAnchor : animatableControllers[pos-1].viewController.view.bottomAnchor
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
        guard (currentPos() + 1) < animatableControllers.count else { return }
        animate(viewToAnimate, to: animationStep())
        customDelegate?.scrollViewDidScroll(self)
    }
    
    private func animate
        (_ view: ViewToAnimate , to step: CGFloat) {
        view == .current ?
            animatableControllers[currentPos()].animate(step: step) :
            animatableControllers[currentPos()+1].animate(step: step)
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
