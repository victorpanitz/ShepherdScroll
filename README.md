![alt text](https://i.imgur.com/OCKpL18.jpg)

## Let me do the job for you
Shepherd Scroll implements a custom Scroll View which provides easy handling of animation over child view controllers during the scroll.

 ## Installing
1. Add to your Podfile


```ruby
pod 'ShepherdScroll' ~> '0.1.2'
```
#### 2. Run pod install

## Shepherding the sheep

After install your pod, import Shepherd Scroll to the UIViewController which the scroll will be embedded in (make sure you have builded your application before that).

```swift
import ShepherdScroll
```
> ##### we'll get back to this controller soon, but now let's create the sheep's! meeeh 
> ##### context.saveGState()


### Ready to rock?
Firstly you'd need an array of UIViewController which implements Animatable protocol. Wtsheep is that?
> ##### Take it easy ma'friend.
Create a standard UIViewController, import ShepherdScroll and inherit Animatable protocol to the UIViewController.
```swift

import UIKit
import ShepherdScroll
class SheepAViewController: UIViewController, Animatable {
```
Using Animatable you'll be able to control your own animation as you want! Exactly! Shepherd Scroll doesn't know what the view controller's content is, giving you the freedom to create animations, parallax and much more on your way.

To do that, call the method animate() where you'll receive a value between 0 and 1. See this value as a timeline from 0% to 100% of the animation. With this value you'll get nice results during the scroll (no matter what direction you scroll). 

> ### Use your imagination to do whatever you want with this percentage like translate images, views, animate graphs, change alpha's and much more.

```swift
override func animate(step: CGFloat) {
        label.alpha = 0.3 + step
        label.transform = CGAffineTransform(scaleX: 1 + step, y: 1 + step)
            .concatenating(CGAffineTransform(translationX: 0, y: 200 * step))
}
```


> #### Here is the full example:

```swift
import UIKit
import ShepherdScroll

class SheepAViewController: UIViewController, Animatable {

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

    func animate(step: CGFloat) {
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

### Le grand finale!
> ##### context.restoreGState()
You have set up your Sheep as any basic UIViewController, but here's where the magic happens! 
In your main UIViewController you will add the ShepherdScrollView as any UIScrollView but setting some cool parameters.

```swift
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

After that, just set the constraint to this component.
```swift
private func setupConstraints() {
        guard let `scrollView` = scrollView else { return }
        
        NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
```

> #### @  Check it out more details in the demo. @


> ### Vertical mode (You can even define a offset)
![Alt Text](https://media.giphy.com/media/3oa9SrtaXg57DzB96K/giphy.gif)  

> ### Horizontal mode
![Alt Text](https://media.giphy.com/media/4MWlhv5u6fQZevvP9G/giphy.gif)

