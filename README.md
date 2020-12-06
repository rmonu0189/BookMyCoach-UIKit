# BookMyCoach iOS Prototype Application

## Introduction

The iOS mobile application prototype built using Swift 5.3 using Xcode 12.2. The minimum iOS requirement is iOS 14.0

Building blocks of the prototype are- 

1. Clean Architecture  - We used the 'Clean Architecture' (https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).
2. MVVM - MVVM along with the Clean Architecture helps us to achieve the SOLID principles of the software development.
3. Reactive programming - Swift Closures are used to achieve the react programming without use of any third party library. 
4. Depending Injection and factory methods to create object and injecting dependency as required that ensure loose coupling between objects. 

## Benefits - 
Clean Architecture +  MVVM gives us a number of benefits, including - 

1. Testable. The business rules can be tested without the UI, Database, Web Server, or any other external element.
2. Independent of UI. The UI can change easily, without changing the rest of the system. A Web UI could be replaced with a console UI, for example, without changing the business rules.
3. Independent of Database. You can swap out CoreData or SQLite etc for local database or use web server APIs to get data from remote servers.

## Overview

This is a prototype app to demonstrate iOS app development using Clean Architecture + MVVM and react programming without using third party library.

- To use the app run download the source code and run the app on iOS simulator using Xcode 12.2 or higher.
- Register using your email as a Coach or Player and complete your profile
-  A player can see Nearby available coaches, their current bookings with one more coaches according to their current location on their home screen.
- A player can send a booking request to any coach available for the booking to book their session with the coach.
- Coach can login and see all their pending booking request on their home screen along with the already accepted bookings.
 - A coach can either accept or reject a booking request.
 - Both coach and Player user can update their profiles which includes -
   - Update personal informations like Full Name, hourly price, profile photo, etc.
   - Update password
   - Coach can also update their sport of coaching 
   -  See privacy policy and terms of services
   - User can logout from their account

## Folder structure of the App- 

- Application: Contains application level files like 
    - AppDelegate
    - Plist
    - FlowCoordinator 
- Utilities: This folder contains utility files like validation, date helpers, etc.
- Presentation Layer: - This folder represent the Presentation Layer of the Clean Architecture. This layer contains all the View, ViewController and ViewModel. This folder is further categorized based on the app sections like - Authentication, Home, Profile, etc.
- Domain Layer:  This folder represent the Domain layer of the Clean Architecture. This layer contains -
    - Entity: Model classes.
    - UseCase: This contains all the use cases that define the application business logic.
    - Protocol: This contains protocol for for the repositories consists in the Data layer.
- Data Layer: This folder represent the Data layer of the Clean Architecture. This layer contains -
    - Repository - This folder contains the repository implementations defined in the 'Protocol' section of the Domain layer.
    - DataBase - We can have local database like CoreData, files, etc in this folder.
    - Network- This folder contains the network request files and handle all the network related tasks.
    - Utils-This folder contains utilities manager classes like LocationManager, UserManager, etc.
- Resources - This folder contains the resources required by the app. Like -
    - Constants
    - Firebase plist file (You may have to create your own plist or get it from me in order to run the app).
    - Assets - contains images and colors for used in the app.
