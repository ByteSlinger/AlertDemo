# AlertDemo
iOS Swift UIAlertController with UIControl to dismiss on tap

Here are the screenshots from the app:

<img src="" />

## Overview
I needed alert notifications similar to the Android Toast functionality (alert popups WITHOUT action buttons).  There are GitHub repos with iOS frameworks that behave similar to the Android Toast, but I wanted something simple that uses the native iOS code.  Also I wanted to be able to dismiss the alert popups by tapping on them OR timing out.  This app demonstrates 4 ways to dismiss an alert popup:

1) Timeout - dismiss an Alert Window after a number of seconds (like Android Toast)
2) Tap outside the Alert Window (tap on Alert Window DOES NOT close it)
3) Tap the Alert Window (tap anywhere else DOES NOT close it)
4) Tap anywhere on the screen (on Alert Window or outside of it) to close it

All 4 will eventually close after a timeout delay of 3 seconds.

## Prerequisites

You will need the following to build and run this app:

* Apple Macintosh computer
* Xcode application installed and configured (I used Version 9.2)
* Copy of this repository (click "Clone or Download" on main page) [GitHub repo](https://github.com/ByteSlinger/AlertDemo.git)

## Build and Deployment

I selected my iPhones to build and deploy to.  I did not try to test in the Xcode simulator.

* iPhone 5 - iOS Version 10.3.3
* iPhone 6+ - iOS Version 11.2.1
* Xcode deployment target - 10.3 (so the app would run on my old iPhone 5...)

## Code Highlights
* I use a **UIControl** that sits on top of the alert and responds to any touch event, to dismiss the alert
* It is important to set the frame properly on the UIControl - the bounds on the alert or the superview works the best
* I needed **NSObject.cancelPreviousPerformRequests(withTarget: self)** to cancel existing perform requests to be sure that previous timed dismiss attempts did not accidentally dismiss other alerts.  This was noticable when you go through the app quickly, tapping buttons, and right away tapping the alerts.

## Usage
Everything is done in [ViewController.swift](./ViewController.swift).  You will need to cut-and-paste from there into your own project.

## Author

* [ByteSlinger](https://github.com/ByteSlinger)

## License

This project is licensed under the MIT License: https://opensource.org/licenses/MIT

## Acknowledgments
I refer to this repo on a StackOverFlow.com question/answer:  https://stackoverflow.com/questions/48352231/in-ios-how-do-i-close-an-alert-controller-by-tapping-inside-the-alert-popup
