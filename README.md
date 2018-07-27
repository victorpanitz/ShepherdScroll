![alt text](https://i.imgur.com/OCKpL18.jpg)

## Let me do the job for you
##### Shepherd Scroll implements a custom Scroll View which provides easy handling of animation over child view controllers during the scroll.

 ## Installing
 #### 1. Add to your Podfile

```
pod 'ShepherdScroll' ~> '0.0.7'
```
#### 2. Run pod install

## Shepherding the sheep
##### After install your pod, import Shephered Scroll to the UIViewController which the scroll will be embbed in (certify you have builded your application before that).
```
import ShepherdScroll
```
> ##### we'll back to this controller soon, but now let's create the sheep's! meeeh 
> ##### context.saveGState()


### Ready to rock?
##### Firstly you'd need an array of BaseAnimatedViewControllers. Wtsheep is that?
> ##### Take it easy ma'friend.
##### Create a standard UIViewController, import ShepherdScroll to that and change the UIViewController inheritance to BaseAnimationViewController.
```
import UIKit
import ShepherdScroll
class SheepAViewController: BaseAnimatedViewController {
```
##### Using a BaseAnimatedViewController you'll be able to control your own animation as you want! Exactly! Shepherd Scroll doens't know what's the view controller content giving you freedom to create animations, paralax and much more on your way.

##### To do that, overrides the method animated() where you'll receive a value between 0 and 1. See this value as a timeline from 0% to 100% of the animation. with this value you'll get nice results during the scroll (to both sides).

```
override func animate(step: CGFloat) {
        label.alpha = 0.3 + step
        label.transform = CGAffineTransform(scaleX: 1 + step, y: 1 + step)
            .concatenating(CGAffineTransform(translationX: 0, y: 200 * step))
}
```

> #### Here is the full example:

```
import UIKit
import ShepherdScroll

class SheepAViewController: BaseAnimatedViewController {

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0.3
        label.text = "DRAG UP"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupLayout()
    }

    override func animate(step: CGFloat) {
        label.alpha = 0.3 + step
        label.transform = CGAffineTransform(scaleX: 1 + step, y: 1 + step)
            .concatenating(CGAffineTransform(translationX: 0, y: 200 * step))
    }
    
    private func setupLayout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
```

### Le grand Finale!
> ##### context.restoreGState()
##### You have setted up your Sheep as any basic UIViewController, but here's where the magic happens! 
##### In your main UIViewController you will add the ShepherdScrollView as any UIScrollView but setting some cool parameters.

```
    private func setupShepherdScroll() {
        scrollView = ShepherdScrollView(
            controller: self,
            viewControllers: [SheepAViewController(), SheepBViewController(), SheepCViewController()],
            size: view.frame.size,
            viewToAnimate: .next,
            orientation: .vertical,
            offset: 0.0)
        
        guard let `scrollView` = scrollView else { return }
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
```

##### After that, just set the constraint to this component.
```
private func setupConstraints() {
        guard let `scrollView` = scrollView else { return }
        
        NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
