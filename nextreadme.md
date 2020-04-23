
# NetunoNavigation
Navigate as a Godness.

[NetunoNavigation](https://cocoapods.org/pods/NetunoNavigation) is a pod to iOS to make easily your navigation on the plataform.

## Installation
You can install NetunoNavigation with [CocoaPods](http://cocoapods.org/).

```ruby
pod 'NetunoNavigation', '~> 0.0.5'
```
##  Implementing
After you install NetunoNavigation with CocoaPods you can to import `NetunoNavigation` into your class:

```swift
import NetunoNavigation
```
When you to import navigation you can start utilize `Navigator` class, and implement it:

```swift
import UIKit
import NetunoNavigation

class ExampleViewController : UIViewController {

	var navigate: Navigator?
	
	override  func  viewDidLoad() {
		super.viewDidLoad()
		self.navigate = Navigator(navigationController: self.navigationController)
	}	
}
```
_This is the basic of how to start to use this pod._

Now that you have `Navigator` initialised you can use all it's navigation functions.

## Let's start from the beginning


---
### navigate.toGo(...)
This method is used when you don't need to send data to next `UIViewController`.

The function explained is:
```swift
func toGo<T: UIViewController> (
	_ actualViewController: UIViewController,
	_ viewControllerToGo: T.Type,
	segue: Segue = .push,
	animated: Bool = true,
	_ completion: (() -> Void)? = nil
)
```
|Parameter | Description |
|--|--|
| actualViewController | Current viewController that you'll use the navigation, you can put `self` into this parameter |
| viewControllerToGo | Is ViewController that you want to go, you need had class created to put viewController type here. Example: `AnotherViewController.self` |
| segue* | Is an enumeration that serves to control how you need to open your viewController. Default is: `.push` |
| animated* | If you want that your ViewController open with animation |
| completion* | When the next ViewController will be completed, this closure is called |
*_optional parameters_


