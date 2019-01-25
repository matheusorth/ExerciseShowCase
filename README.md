# ExerciseShowCase

MVVM + Today Widget + CLLocation + REST

![](sampleExerciseApp.gif)

## Exercise

This exercise was devided in 2 Tasks:

## Task1

Objective
Fetch a list of exercises from the following API and display them using an appropriate list
layout. This list should be paginated and fetch the next page when the user scrolls down and
reaches the end of the current page.
API: https://wger.de/de/software/api
Every list item should have:
* The name of the category the exercise belongs to
* The name of the exercise
* An image of the exercise or a placeholder if no image available.
* The equipment needed for the exercise (comma separated), if provided.
* The muscles trained by this exercise (comma separated), if provided.

## Task2

Objective
Create a detail view that provides additional information of an exercise. Navigate to this view
when a user selects an item in the exercise list.
The detail view should show:
* The name of the category the exercise belongs to
* The name of the exercise
* All images of the exercise in a horizontal view, if provided
* The description of the exercise, if provided
* A list of the equipment needed for the exercise, if provided
* A list of the muscles trained by this exercise, if provided


## Dependencies
|#|Library|Description|
|-|-|-|
|1|[Alamofire](https://github.com/Alamofire/Alamofire)|Elegant HTTP Networking in Swift.|
|2|[Kingfisher](https://github.com/onevcat/Kingfisher)|A lightweight, pure-Swift library for downloading and caching images from the web.|

## Build instructions

1. An OSX machine
2. Xcode 10.x or higher (Swift 4.2)
3. Install [CocoaPods](https://cocoapods.org/) 
4. Clone this repo:
```
git clone https://github.com/matheusorth/ExerciseShowCase
```
5. Download library dependencies using the cocoapods dependency manager (and update the same way):
```
pod install
```
6. Open the Xcode workspace.
7. Build the project by ⌘ + R
