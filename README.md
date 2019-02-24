# MailApp

## Table of Contents

* [About](#About)
* [Dependencies](#Dependencies)
* [Architecture](#Architecture)
* [Version history and roadmap](#Versioning)
* [Requirements](#Requirements)
* [Installation](#Installation)
* [Author](#Author)

<a name='About'/>

## About

MailApp is an app that lets the user fetch posts from [JSONPlaceHolder](https://jsonplaceholder.typicode.com/), unread posts are marked with a blue dot, the users can delete the posts one by one or all at the same time, also the user can add a post to favorites and filter them in the list.

<a name='Dependencies'/>

## Dependencies

### Direct Dependencies

* [Alamofire](https://github.com/Alamofire/Alamofire): Networking layer of the App.
* [Realm](https://realm.io/docs/swift/latest): Cache layer of the App.
* [ViewAnimator](https://github.com/marcosgriselli/ViewAnimator): Used for some animations
* [SwiftEntryKit](https://github.com/huri000/SwiftEntryKit): Used to show error messages

### Transitive Dependencies

* [QuickLayout](https://github.com/huri000/QuickLayout): Used by SwiftEntryKit.

<a name='Architecture'/>

## Architecture

This app was built following the MVP Architectural pattern, this pattern was chosen because of its ease of use and its testability is excellent, most of the business logic can be tested due to the dumb view, adapter pattern was also implemented to decouple the app from third party libraries this makes easier to switch between third party libraries

<a name='Requirements'/>

## Requirements

* Xcode 10.1 or higher
* [Carthage](https://github.com/Carthage/Carthage) version 0.31.2 or higher
* iOS 12.1 SDK or higher

<a name='Installation'/>

### Running the App

To run the App:
* Clone the repo
* In the root directory, run  `carthage bootstrap --platform ios` 
**- Optional:** For a full update of all dependencies, run `carthage update --platform ios` which will update dependencies of the App at your own risk
* Open Xcode workspace and run the target from the project in WDPRResortUIDemo directory.

## Author
* [Santiago Avila Arroyave](https://www.linkedin.com/in/santiago-avila/)
