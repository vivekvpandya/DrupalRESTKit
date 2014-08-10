DrupalRESTKit
=============

![alt tag](https://dl.dropboxusercontent.com/u/100492838/DrupalRESTKit.png)


DrupalRESTKit is an iOS 7.x  library built on the top of AFNetworking. It simplifies developer tasks to consume REST services provided by Drupal 8. Currently it simplifies CRUD operations on 'node' and 'user' entity type. It configures request parameter as per requirements for example while POST request it will set content-type to "application/hal+json". It let you focus on your application rather than managing complex parameters and configuration for REST requests. Currently we are working class realation between drupal entities it will make it more joyful.

#Installation with CocoaPods

```ruby
platform :ios, '7.0'

pod 'DrupalRESTKit', :git => 'https://github.com/vivekvpandya/DrupalRESTKit.git'
```

#Requirements
iOS 7 or above

#Usage
Import ``` Drupal8RESTSessionManager.h``` and you are good to go. Here in my example I am using http basic auth authentication type when required.

### ```GET``` Request on node
Create instance of manager , set accept header.
```objective-c
  Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
   
    [manager setValue:@"application/hal+json" forHTTPRequestHeader:@"Accept"];
    
    
    
    [manager GETNode:self.baseURL
              nodeId:@"57"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"%@",responseObject);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
    
    
}
```
### `POST` Request on node
Set Authorization if any required. Build parameters and POST a node. Here if you are posting an article pass bundle type as ```@"article"``` and pass parameters accordingly. 

 ```objective-c
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"your base 64  basic auth string " forHTTPHeaderField:@"Authorization"];
    
    
  NSDictionary *parameters=  @{
  @"uid":@[@{@"target_id":@"1"} ],
  @"field_tag":@[@{@"target_id":@"1"}],
  @"body":@[@{@"value":@"This is text",
              @"format":@"full_html"}],
              @"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]
              };
    
    
   [manager POSTNode:self.baseURL
          bundleType:@"tip"
          parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"OK POSTED");
   }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
```
### `PATCH` Request on node
Same as POST on node.
```objective-c
 Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"your base 64  basic auth string" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],
    @"field_tag":@[@{@"target_id":@"2"}],
    @"body":@[@{@"value":@" Hey I have updated this node via drupal 8 ios kit ",
                @"format":@"full_html"}],
    @"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]
    };
    
   
    [manager PATCHNode:self.baseURL
            bundleType:@"tip"
                nodeId:@"61"
            parameters:parameters
               success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"UPDATED !");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
  ```  

### `DELETE` Request on node

```objective-c
 Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    
    
    [manager setValue:@"your base 64  basic auth string" forHTTPRequestHeader:@"Authorization"];
    
    [manager DELETENode:self.baseURL 
                 nodeId:@"55" 
                 success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ok deleted");
    }            failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

```
### `GET` data from View based REST Export
Here viewName is path for your REST Export.
```objective-c
Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager GETView:self.baseURL
            viewName:@"vocabulary/foss"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"%@",responseObject);
    }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];

```
### `POST` comments on node
Here targetEntityId is an entity id on which comment will be posted.
```objective-c
  Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
   
    [manager setValue:@"your base 64  basic auth string" forHTTPRequestHeader:@"Authorization"];
    
    NSDictionary *parameters = @{
                                 
    @"subject":@[
    @{
        @"value":@"A comment with Drupal 8 iOS sdk !"
    }
                ],
    @"comment_body":@[
    @{
        @"value":@"<p>Drupal 8 will rock !.</p>\r\n",
        @"format":@"basic_html"
    }
                    ]
                                 
                                 };
    

    [manager POSTComment:self.baseURL
          targetEntityId:@"16"
              parameters:parameters
                 success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Comment POSTED !");
    }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

```
### `GET` on comments 
To get all comments for particular node create REST export for a view. Set entity nid as contextual filter parameter. Now use `GETView` method. [Tutorial on Contextual Filter with view](http://tntfoss-vivekvpandya.rhcloud.com/node/64) 

### `PATCH` on comments
```objective-c
  
   Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager.sessionManager.requestSerializer setValue:@"your base 64  basic auth string" forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{
                                 @"subject":@[
                                         @{
                                             @"value":@"A comment update with Drupal 8 iOS sdk !"
                                          }
                                         ],
                                 @"comment_body":@[
                                         @{
                                             @"value":@"<p>Drupal 8 will rock !. Drupal 8 SDK will also rock.</p>\r\n",
                                             @"format":@"basic_html"
                                            }
                                         ]
                                 
                                 };
    
    [manager PATCHCommment:self.baseURL
                 commentId:@"6"
                parameters:parameters
                   success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Comment updated !");
    }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

```
### `DELETE` on comment
```objective-c
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"your base 64  basic auth string" forHTTPHeaderField:@"Authorization"];
   
    [manager DELETEComment:self.baseURL
                 commentId:@"12"
                   success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Comment deleted !");
    }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

```
similarly CRUD for user entity type is also available.

#Credits
This SDK has been created as a part of a GSoC 2014 project called [Example iOS app for Drupal 8 ](https://github.com/vivekvpandya/TipsAndTricksAFNetworkingDrupal) by [Vivek Pandya ](https://github.com/vivekvpandya)
and [Jeff Linwood ](https://github.com/jefflinwood) as mentor.

#Maintainers
[Vivek Pandya ](https://github.com/vivekvpandya) [@VivekvPandya ](https://twitter.com/VivekvPandya)

#License
DrupalRESTKit is available under MIT license. See LICENSE file for more info.

#### Help us to improve, send us a pull request.
![alt tag](https://dl.dropboxusercontent.com/u/100492838/53471681.jpg)
