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
