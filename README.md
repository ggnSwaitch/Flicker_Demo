# Flicker_Demo
Flicker_Demo
========

This repository contains a simple sample app using the Flicker API to be used as a coding assignment for mobile developer candidates.


# Architecture

This app has deigned using well-known Model-View-ViewModel (MVVM) pattern to provide loose coupling between separate layers and provide a clear separation of concerns between them. It is also useful for maintainability and it also avoids the Massive-View controllers problem.
The app supports both potrait and landscape modes for iphone and potrait mode for iPad.

Typically the project structure has the followings:  

2.    ***Models*** – The data model to represent an entity. eg. Photos  
3.    ***View-Models*** – The model representing the data necessary for the view to display itself; but it’s also responsible for gathering, interpreting, and transforming that data
4.    ***View-Controllers*** – The controllers that directly interact with the UI and manage the UI state. The code for Views and View-Controllers have similar goals and they are commonly categorised into one category  

The communication between view-models and view-controllers can happen in many different ways - delegates, callback blocks, notifications, KVO, target/action event observers. Each of this approach has its own pros and cons. I have used callbavk blocks in this project

# Issues & Limitations
There are a few issues with the app that can be improved.
* View-controllers can be improved with using RxSwift.
* The UX and UI design for the app is very limited and basic. With more time better UX and can be designed. e.g support for different iPad and iPhone versions
* With more time More efforts could be given to cover unit test cases especially for ViewModel and Mock objects using frameworks such as Quick and Nimble.
* Protocols can be used to cover testing.
* Error handling and the way errors shows to the user need be improved in  Session classes
* Drag and referesh functionality can be added with more time.

---
# iOS Code

This application is not meant to be an example of how code should be written, but rather an opportunity to think about better ways of breaking down and structuring code in a simple context.


This app uses the Flicker API. To use the API, you need the API key and the search text e.g "Cars" to first connect with an endpoint to get the photo information such as server, secret and PhotoID. That  can then be used for future calls.
In this app, I'm retrieving the photos from the API by specifying the number of items per page and the the page number in the API call. The items per page limit in this app is 20, which means the api call will give 20 items per page until the new page is required.

To retrieve an photos information, you hit this endpoint

`https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&text=Cars&format=json&nojsoncallback=1&per_page=20&page=1` and retrieve the information from the response. 

```
"photos":{
"page":1,
"pages":7553,
"perpage":20,
"total":"151052",
"photo": {
    "id": "39593986652",
    "owner": "36739135@N04",
    "secret": "0ec416669f",
    "server": "4740",
    "farm": 5,
    "title": "IMG_5508",
    "ispublic": 1,
    "isfriend": 0,
    "isfamily": 0
},
```

We can then use this information - farm,server, secret and photoID to retrieve the photos.  `http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg`, returns the image:

Everytime the user scrolls, the app will call the api and download new images as required  checking the index path and the page number. 
'```if indexPath.row == lastRowIndex && paging != nil ```

