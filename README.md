# Marvel

## About
This repo contains the implementation of the Farfetch iOS Tech Test.
(iOS_Exercise.pdf)[./iOS_Exercise.pdf]

## Setup
- After cloning the project, add a file called `MarvelKeys.swift` inside the same folder the main `Info.plist`; 
- Add the following content to this file with your respective keys:
```swift
enum MarvelKeys {
    static let `public` = "[YOUR MARVEL PUBLIC KEY]"
    static let `private` = "[YOUR MARVEL PRIVATE KEY]"
}
```

That's all. Open Xcode and Run. 