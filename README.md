# Marvel

[![Mutation Test](https://img.shields.io/badge/code%20coverage-75%25-green.svg)](./muter-report)
[![Mutation Test](https://img.shields.io/badge/mutation%20score-55%25-orange.svg)](./muter-report)


## About the Test
This repo contains the implementation of the Farfetch iOS Tech Test: <br>
[iOS_Exercise.pdf](./iOS_Exercise.pdf)

## Pending Scope **(features not present)**
- Search
- Favourite
- UITests


## Setup
- Clone the project;
- Add a file called `MarvelKeys.swift`; 
- Add the following content to this file with your respective keys:
```swift
enum MarvelKeys {
    static let `public` = "[YOUR MARVEL PUBLIC KEY]"
    static let `private` = "[YOUR MARVEL PRIVATE KEY]"
}
```

That's all. Open Xcode and Run. 

## Architecture
- MVP, Model View Presenter;
- The Presenter layer has collaborators to avoid to get massive;
- Pending (Draw)

## Notes
- The app is providing feedbacks when the user get any request issue and retry options;
- There are two kinds of Stores: DataStore and TableStore. The first one is holding the state of the scene, and it is exposing its properties only to the Presenter. Otherwise, the TableStore is exposing, in read-only mode, the values to show;
- A Strings file is holding all the strings visible for the user;
- Thumbnails contain a cache logic to avoid re-fetch the same image during the table scrolling;
- The Hero object was implemented as a Class to hold the state about fetched content (such as comics, series, stories, and events);
- The Details scene is accessible only if the Here has content available to present;
- I tried to import UIKit only where it was indispensable.
- I wrapped up all the UI elements in a separated class to clean up the ViewController.
- A Bootstrap class is enabling testing for the  boilerplate code around the launch;
- The code is preventing present the first real scene during the test executions; This lock is to avoid increasing the code coverage without having any test written.
- I used reflection (Mirror class) to perform some validation into private properties to avoid exposing unnecessarily;
- I executed the Muter after finish the project, and the report is available here: [muter-report](./muter-report).

## Muter
1. Install Muter (if you don't have yet);
> https://github.com/muter-mutation-testing/muter#installation
2. On terminal, in the project's folder, run the command `muter`:
> $ muter
