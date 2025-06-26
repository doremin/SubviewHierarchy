# SubviewHierarchy

A **lightweight**, **SwiftUI-inspired** DSL for building UIKit `UIView` hierarchies in a clean, declarative way.

> 🧪 Fully covered by tests.
> ⚡ No external dependencies.
> Only 4KB in Binary Size.

## 🧱 Basic Usage

```swift
let box1 = UIView()
let box2 = UIView()
let box3 = UIView()

override func viewDidLoad() {
    super.viewDidLoad()
    view {
      box1 {
        box2
        box3
      }
    }
}
```

The above code is equivalent to:

```swift
let box1 = UIView()
let box2 = UIView()
let box3 = UIView()

override func viewDidLoad() {
    super.viewDidLoad()
    box1.addSubview(box2)
    box1.addSubview(box3)
    view.addSubview(box1)
}
```

## 📚 Conditional View Injection

```swift
let shouldShow = true

let container = UIView() {
    if shouldShow {
        UILabel()
    } else {
        UIImageView()
    }
}
```

## 🧩 Array Injection

```swift
let buttons = (0..<3).map { _ in UIButton() }

let container = UIView() {
    buttons
}
```

## 🛠 Requirements

- Swift 5.4+
- iOS 13+

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/doremin/SubviewHierarchy.git", .upToNextMajor(from: "1.0.0"))
]
```

## 🔖 License

SubviewHierarchy is released under the MIT License. See [LICENSE](LICENSE) file for more details
