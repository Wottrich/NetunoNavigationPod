
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

# All functions you need to know

##  Navigate
###### _To see documentation. Click at →_
### > .to / .go
[→]() Navigate to a UIViewController that is on current storyboard with data:
```swift
navigate.to(
	_ currentViewController: self,
	viewControllerToGo: AnotherViewController.self,
	prepare:{(viewControllerToGo: AnotherViewController) in ...}
)
```

[→]() Navigate to a UIViewController that is on another storyboard with data:
```swift
navigate.to(
	_ storyboardToGo: "NameOfStoryboardToGo",
	viewControllerToGo: AnotherViewController.self,
	prepare:{(viewControllerToGo: AnotherViewController) in ...}
)
```

**Both functions return [Go]() class and it has:**

[→]() When you are using .to(...) you need to call .go(...) after it. If you don't do it, you don't go anywhere:
```swift
navigate.to(/*Whatever type*/).go(segue: .push(animated: true))
navigate.to(/*Whatever type*/).go()

//or

let navigationToAnotherViewController = navigate.to(/*Whatever type*/)

navigationToAnotherViewController.go()
navigationToAnotherViewController.go(segue: .push(animated: true)
```
### > .toGo
[→]() If you want just to go to another UIViewController without sending data:
```swift
// on current storyboard
navigate.toGo(
	_ currentViewController: self,
	viewControllerToGo: AnotherViewController.self,
	segue: .push(animated: true)//default: .push(animated: Go.defaultAnimated)
)

// on another storyboard
navigate.toGo(
	_ storyboardToGo: "NameOfStoryboardToGo",
	viewControllerToGo: AnotherViewController.self,
	segue: .push(animated: true)//default: .push(animated: Go.defaultAnimated)
)
```
###### [Go.defaultAnimated is true, click here to know how to change.]()

## Stack
###### _To see documentation. Click at →_

[→]() Navigate to a new stack sending data or not:
```swift
// on current storyboard
navigate.newStack(
	_ navigationControllerToGo: "IdentifierNavControllerToGo"
)

// on another storyboard
navigate.newStack(
	_ navigationControllerToGo: "IdentifierNavControllerToGo",
	_ storyboardToGo: "NameOfStoryboardThatHasYourNavController"
)

```

**Both functions return [Stack]() as optional, and Stack has:**

After you create your stack you need to specify to where you'll go:

[→]() To specify an UIViewController and to send data:
```swift
navigate.newStack(/*Whatever type*/).to(
	viewControllerToGo: AnotherViewController.self,
	prepare: {(viewControllerToGo: AnotherViewController) in ...}
)

//or

guard let myNewStack = navigate.newStack(/*Whatever type*/) else {return}

myNewStack.to(
	viewControllerToGo: AnotherViewController.self,
	prepare: {(viewControllerToGo: AnotherViewController) in ...}
)
```
**This function return [StackGo]() that you need to call to send your UIViewController to stack:**
```swift
navigate.newStack(...).to(...).go(
	modalPresentationStyle: .fullScreen, //default value
	animated: true, //default value
	_ completion: {} //optional
)

//or

guard let myNewStack = navigate.newStack(...) else {return}

let to = myNewStack.to(...)

to.go(
	modalPresentationStyle: .fullScreen, //default value
	animated: true, //default value
	_ completion: {} //optional
)
```

[→]() To specify an UIViewController and just go:
```swift
navigate.newStack(/*Whatever type*/).toGo(
	viewControllerToGo: AnotherViewController.self,
	modalPresentationStyle: .fullScreen, //default value
	animated: true, //default value
	_ completion: {} //optional
)
```
**Now, if you just want a new stack, there is nothing faster than this function:**
```swift
// on current storybaord:
navigate.newStackToGo(
	_ navigationControllerToGo: "IdentifierNavController",
	viewControllerToGo: AnotherViewController.self,
	modalPresentationStyle: .fullScreen, //default value
	animated: true, //default value
	_ completion: {} //optional
)

// on another storybaord:
navigate.newStackToGo(
	_ navigationControllerToGo: "IdentifierNavController",
	_ storyboardToGo: "NameOfStoryboardThatHasYourNavController"
	viewControllerToGo: AnotherViewController.self,
	modalPresentationStyle: .fullScreen, //default value
	animated: true, //default value
	_ completion: {} //optional
)
```

# The end of the beginnings
Complete wiki [click here](https://github.com/Wottrich/NetunoNavigationPod/wiki).

If you are on the cocopoads page: Access our [github](https://github.com/Wottrich/NetunoNavigationPod).

If you are on the github page: Access our [cocopods](https://cocoapods.org/pods/NetunoNavigation).

If you aren't on these pages, where are you? 🤔
