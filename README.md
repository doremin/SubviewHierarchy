# SubviewHierarchy

A SwiftUI-inspired DSL that lets you build `UIView` hierarchies in a clean, declarative way.

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
