<p align="center">
  <img src="Media/AltIcon-logo.png" alt="Logo" width="80" height="80">
  <h2 align="center">
    AltIcon
  </h2>
</p>

!!! iOS 13.0+

!!! A package that let's you change App Icon without an alert.
!!! Image of alert

<img src="Media/showcase.gif" alt="GIF">

<br>

## Installation
To install AltIcon using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for this repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter `https://github.com/matt-novoselov/AltIcon.git`

## Usage
1. !!!!
2. !!!!
   
```swift
import SwiftUI
import AltIcon

struct ContentView: View {
    var body: some View {

        Button("Set Alternative Icon") {
            setAppIcon("AppIcon2")
        }

        Button("Set Back Main Icon") {
            setAppIcon(.main)
        }

    }
}
```

## Issues
Have an issue with the package, or want to suggest a feature/API to help make your development life better? Log an issue in the issues tab! You can also browse older issues and discussion threads there to see solutions that may have worked for common problems.

<br>

> [!WARNING]  
> This package uses Apple's private APIs. AltIcon uses obfuscation, but there is a chance that Apple could detect this during the App Store review process. Use at your own risk.

<br>

## Credits
Distributed under the MIT license. See **LICENSE** for more information.

Developed with ❤️ by Matt Novoselov
