![GitHub stars](https://img.shields.io/github/stars/wottrich/NetunoNavigationPod?style=social)
![GitHub forks](https://img.shields.io/github/forks/wottrich/NetunoNavigationPod?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/wottrich/NetunoNavigationPod?style=social)

![](https://img.shields.io/badge/Version-1.0.0-green)
![GitHub license](https://img.shields.io/badge/License-MIT-blue.svg)
![platform](https://img.shields.io/badge/platform-iOS-blue.svg)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/wottrich/NetunoNavigationPod)

# 🔱 NetunoNavigation 🔱
Navigate like a god.

[NetunoNavigation](https://cocoapods.org/pods/NetunoNavigation) is a pod to iOS to take navigation to the next level on the platform.


## Installation
You can install NetunoNavigation with [CocoaPods](http://cocoapods.org/).

```ruby
pod 'NetunoNavigation', '~> 0.0.5'
```

## Implementing
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

## Basic about NetunoNavigate

<details><summary>Navigate to another UIViewController</summary> 

**> to**
| Params | Example |
| -- | -- |
| _ currenctViewController | UIViewController |
| viewControllerToGo | T.Type  |
| prepare | ((T?) -> Void)? = nil |

Return: [Go]()

**> toGo**

if you don't need to use prepare you can use .toGo:
| Params | Example |
| -- | -- |
| _ currenctViewController | UIViewController |
| viewControllerToGo | T.Type  |
| segue | Segue = .push(animated: Go.defaultAnimated) |

Return: Bool

```swift
//Transparent
toGo<T: UIViewController>(
  _ currentViewController: String
  viewControllerToGo _: T.Type
  segue: Segue = .push(animated: Go.defaultAnimated)
)

to<T: UIViewController>(
  _ currentViewController: UIViewController
  viewControllerToGo _: T.Type
  prepare: ((T?) -> Void)? = nil
) -> Go

.go(
  segue: Segue = .push(animated: Go.defaultAnimated)
) -> Bool
 
//Example without prepare you can use `toGo`
navigator.toGo(self, viewControllerToGo: AnotherViewController.self)

//Example with prepare
navigator.to(self, viewControllerToGo: AnotherViewController.self) { nextViewController: AnotherViewController? in
	nextViewController.title = "New Title"
}.go()
```
</details>

<details><summary>Navigate to another UIViewController on another Storyboard</summary> 

**> to**
| Params | Example |
| -- | -- |
| _ storyboardToGo | String |
| viewControllerToGo | T.Type  |
| prepare | ((T?) -> Void)? = nil |

Return: [Go]()

**> toGo**

if you don't need to use prepare you can use .toGo:
| Params | Example |
| -- | -- |
| _ storyboardToGo | String |
| viewControllerToGo | T.Type  |
| segue | Segue = .push(animated: Go.defaultAnimated) |

Return: Bool

```swift
//Transparent
toGo<T: UIViewController>(
  _ storyboardToGo: String
  viewControllerToGo _: T.Type
  segue: Segue = .push(animated: Go.defaultAnimated)
)

to<T: UIViewController>(
  _ storyboardToGo: String
  viewControllerToGo _: T.Type
  prepare: ((T?) -> Void)? = nil
) -> Go

.go(
  segue: Segue = .push(animated: Go.defaultAnimated)
) -> Bool
 
//Example without prepare you can use `toGo`
navigator.toGo("AnotherStoryboard", viewControllerToGo: AnotherViewController.self)

//Example with prepare
navigator.to("AnotherStoryboard", viewControllerToGo: AnotherViewController.self) { nextViewController: AnotherViewController? in
	nextViewController.title = "New Title"
}.go()
```

</details>

<details><summary>Navigate to another UINavigationController</summary> 

`.newStack` is used to configure **UINavigationController** and/or **UIStoryboard** that you want to navigate.
To navigate to another screen you need to use `.to` to configure **UIViewController** and/or **prepare** and `.go` to configure how you want to open your screen.
But if you want only **go** you can use `.toGo`.

**If you want to navigate to another Storyboard use `storyboardToGo` param**

**> newStack**
| Params | Example |
| -- | -- |
| navControllerToGo | String |
| _ storyboardToGo | String? = nil  |

Return: [Stack]()?

**.to**
| Params | Example |
| -- | -- |
| viewControllerToGo | T.Type |
| prepare | ((T?) -> Void)? = nil |

Return: [StackGo]()

**.go**
| Params | Example |
| -- | -- |
| _ style | ModalStyleEnum = .none |

Return: Void

<details><summary>**Code .newStack example**</summary>

```swift
//Transparent
.newStack(
  navControllerToGo: String,
  _ storyboardToGo: String? = nil
) -> Stack?

.to<T: UIViewController>(
  viewControllerToGo: T.Type,
  prepare: ((T?) -> Void)? = nil
) -> StackGo

.go(
  _ style: ModalStyleEnum = .none
)

//Example same storyboard
let stack = navigate.newStack("NavigationControllerToGo")
//Example another storyboard
let another = navigate.newStack("NavigationControllerToGo", "AnotherStoryboard")

//Without prepare
stack.to(AnotherViewController.self).go()

//With prepare
stack.to(AnotherViewController.self) { nextViewController in
  nextViewController.title = "new title"
}.go()

```
  
</details>

<details><summary>**Code .newStack with .toGo example**</summary>

```swift
//Transparent
.newStack(
  navControllerToGo: String,
  _ storyboardToGo: String? = nil
) -> Stack?

.toGo<T: UIViewController>(
  _ viewControllerToGo: T.Type? = nil
  style: ModalStyleEnum = .modal(modalTransitionStyle: .crossDissolve, modalPresentationStyle: .fullScreen, animated: true, completion: nil)
) -> Stack

//Example
navigate.newStack("NavigationControllerToGo")
  .toGo(AnotherViewController.self)

```
  
</details>

--

**If you don't need to use prepare you can use `.newStackToGo`:**

**> newStackToGo**

| Params | Example |
| -- | -- |
| _ navControllerToGo | String |
| _ storyboardToGo | String? = nil  |
| viewControllerToGo | T.Type? = nil |
| style | ModalStyleEnum = .none |

Return: [Stack]()?

```swift
//Transparent
newStackToGo<T: UIViewController>(
  _ navControllerToGo: String,
  _ storyboardToGo: String? = nil,
  viewControllerToGo: T.Type,
  style: ModalStyleEnum = .none
) -> Stack?

//Example same storyboard
navigate.newStackToGo("NavigationControllerToGo", viewControllerToGo: AnotherViewController.self, .default)

//Example another storyboard
navigate.newStackToGo(
  "NavigationControllerToGo", //navControllerToGo
  "AnotherStoryboard", //storyboardToGo
  viewControllerToGo: AnotherViewController.self,
  style: .default(animated: true, completion: nil)
)

```

</details>

## Wiki in progress...
* [Navigator]()
	* [.To(...)]()
	* [.ToGo(...)]()
	* [.newStack(...)]()
	* [.newStackToGo(...)]()
  
## License
[**MIT License**](https://github.com/Wottrich/NetunoNavigationPod/blob/master/LICENSE)

**Copyright (c) 2020 Lucas Cruz Wottrich.**
