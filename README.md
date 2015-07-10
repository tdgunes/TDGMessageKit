# TDGMessageKit [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![MIT License]( https://img.shields.io/github/license/tdgunes/TDGMessageKit.svg?style=flat) ![Tag](https://img.shields.io/github/tag/tdgunes/TDGMessageKit.svg)


Simplistic custom message box for your view controllers without hassle and it can also jiggle!

![TDGMessageKit](https://raw.githubusercontent.com/tdgunes/TDGMessageKit/master/Example/demonstration.gif)

##Requirements

- iOS 7.0+ (8.0+ recommended)
- Swift 1.2
- Xcode 6.3

##Installation


###Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate TDGMessageKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tdgunes/TDGMessageKit" == 1.0
```

###Manually

If you prefer to not use a depedency manager, you can integrate TDGMessageKit manually into your project.

####Embedded Framework

- Add TDGMessageKit as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the following command:

```bash
$ git submodule add https://github.com/tdgunes/TDGMessageKit.git
```

- Open the new `TDGMessageKit` folder, and drag the `TDGMessageKit.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `TDGMessageKit.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Select the top `TDGMessageKit.framework` for iOS 

- And that's it!

> The `TDGMessageKit.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.


####Source File

For application targets that do not support embedded frameworks, such as iOS 7, TDGMessageKit can be integrated by adding all the Swift files located inside the `TDGMessageKit` directory (`TDGMessageKit/*.swift | TDGMessageKit/*.xib`) directly into your project. Note that you will no longer need to `import TDGMessageKit` since you are not actually loading a framework. Additionally, any of the calling conventions described in the ['Usage'](#usage) section with the `TDGMessageKit` prefix would instead omit it (for example, `TDGMessageKit.TDGMessageBox` becomes `TDGMessageBox`), since this functionality is incorporated into the top-level namespace.

##Usage 

###Showing a MessageBox

```swift
import TDGMessageKit

var messageBox = TDGMessageBox(orientation: .Bottom)  
messageBox.titleLabel.text = "TitleLabel Example Text"  
messageBox.bodyLabel.text = "BodyLabel Example Text"  
messageBox.addTo(self.view)  
messageBox.toggle()  

```

###Supported Orientations 

You can display a message box from top or from bottom. **Supported orientations:**

- `TDGMessageBox.Orientation.Bottom`
- `TDGMessageBox.Orientation.Top`

###Display Methods

- `.toggle()` method hides or shows messsage box according to the current state of the view.
- `.hide()` 
- `.show()`
- `.focus()` makes a cute jiggle animation.


###UI Components

- `titleLabel:UILabel`
- `bodyLabel:UILabel`
- `imageView:UIImageView`

###Touchable

On default every TDGMessageBox comes with a `UITapGestureRecognizer` built-in. If you want to attach a callback to taps to the message box, you can simply:


```swift

messageBox.onTap = {
	println("Got tapped!")
}

```

###Get White

Regularly, you may want to switch image and labels to white, instead of default black. You can do this simply by:

```swift

messageBox.whiten()

```

* * *

## FAQ

### When should I use TDGMessageKit?

If you're starting a new project in Swift, and don't want to waste time on making a reusable message box.


### What's the origin of the name TDGMessageKit, especially `TDG`?

Got influenced by [this](https://git.wiki.kernel.org/index.php/Git_FAQ#Why_the_.27Git.27_name.3F).


* * *

## Acknowledgments

This small documentation is highly adapted from [Alamofire](https://github.com/Alamofire/Alamofire/blob/master/README.md). Thanks for great work!


## License

TDGMessageKit is released under the MIT license. See LICENSE for details.





