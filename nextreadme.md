
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

## Classes into NetunoNavigator

**[Segue]()**
**[Go]()**
**[Stack]()**
**[Navigator]()**


## All functions you need to know
###### _To see documentation. Click at →_

**Navigator > .to:**
viewControllerToGo stay on current storyboard:
**[→]() `func to(_:viewControllerToGo:prepare:) -> Go`**

viewControllerToGo stay on another storyboard:
**[→]() `func to(_:viewControllerToGo:prepare:) -> Go`**

**Go > .go:**
**[→]() `func go(segue:)`**

**Navigator > .toGo**
viewControllerToGo stay on **current** storyboard:
**[→]() `func toGo(_:viewControllerToGo:segue:)`**

viewControllerToGo stay on **another** storyboard:
**[→]() `func toGo(_:viewControllerToGo:segue:)`**

---
**Stack - Managing new flows**

**Navigator > .newStack**
**[→]() `func newStack(_:_:) -> Stack?`**

 * **Stack > .to**	
**[→]() `func to(viewControllerToGo:prepare:) -> StackGo`**

	* **StackGo > .go**
**[→]() `func go(modalPresentationStyle:animated:_:)`**

**Navigator > .newStackToGo**
**[→]() `func newStackToGo(_:_:viewControllerToGo:modalPresentationStyle:animated:_:)`**

