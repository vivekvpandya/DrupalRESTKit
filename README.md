DrupalRESTKit
=============

![alt tag](https://dl.dropboxusercontent.com/u/100492838/DrupalRESTKit.png)


DrupalRESTKit is an iOS 7.x  library built on the top of AFNetworking. It simplifies developer tasks to consume REST services provided by Drupal 8. Currently it simplifies CRUD operations on 'node' and 'user' entity type. It configures request parameter as per requirements for example while POST request it will set content-type to "application/hal+json". It let you focus on your application rather than managing complex parameters and configuration for REST requests. Currently we are working class realation between drupal entities it will make it more joyful.

#Installation with CocoaPods
```
platform :ios, '7.0'

pod 'DrupalRESTKit', :git => 'https://github.com/vivekvpandya/DrupalRESTKit.git'
```
