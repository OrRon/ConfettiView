
![](http://i.imgur.com/kQqv0mb.png)

[![Version](https://img.shields.io/cocoapods/v/ConfettiView.svg?style=flat)](http://cocoapods.org/pods/ConfettiView)
[![License](https://img.shields.io/cocoapods/l/ConfettiView.svg?style=flat)](http://cocoapods.org/pods/ConfettiView)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org/)
[![Platform](https://img.shields.io/cocoapods/p/ConfettiView.svg?style=flat)](http://cocoapods.org/pods/ConfettiView)

# ConfettiView

Confetti View lets you create a magnificent confetti view in your app. This was inspired by [House Party](https://itunes.apple.com/il/app/houseparty-group-video-chat/id1065781769?mt=8) app's login screen. Written in Swift 3 :)

![](http://i.giphy.com/d31wQ2wbLGRQKtTa.gif)

It reacts to the phone accelerometer therefore it's better to run the example project on the device.

## Usage

### With Interface Builder

![](http://i.imgur.com/Myg6obo.png)

Simply pick a view and change it's type to ConfettiView.

### Programaticlly

ConfettiView is a subclass of UIView
```swift
let confettiView = ConffetiView()
self.view.addSubView(confettiView)
```
### Controls

Start or stop the animation:
```swift
confettiView.stopAnimating()
confettiView.startAnimating()
```

Check whether the animation is active:
```swift
confettiView.isAnimating
```

By default the animation starts when the view is initialized

## Installation

ConfettiView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ConfettiView"
```

## Author

Or Ron, or.ron10@gmail.com

## License

ConfettiView is available under the MIT license. See the LICENSE file for more info.
