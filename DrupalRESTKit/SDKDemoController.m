//
//  SDKDemoController.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
// 

/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Vivek Pandya. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "SDKDemoController.h"
#import "Drupal8RESTSessionManager.h"

@interface SDKDemoController ()
@property (nonatomic,strong) NSString *baseURL;
@end

@implementation SDKDemoController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.baseURL = [NSString stringWithFormat:@"http://tntfoss-vivekvpandya.rhcloud.com"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)test:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
  NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"field_tag":@[@{@"target_id":@"1"}],@"body":@[@{@"value":@"This is text",@"format":@"full_html"}],@"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]};
    
    
   [manager POSTNode:self.baseURL
          bundleType:@"tip"
          parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"OK POSTED");
   }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
    
}
- (IBAction)testDelete:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    
    
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    
    [manager DELETENode:self.baseURL nodeId:@"55" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ok deleted");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}
- (IBAction)getView:(id)sender {
    
    
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
    

    
    
}
- (IBAction)testGetNode:(id)sender {
    
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
- (IBAction)getUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    [manager setValue:@"application/hal+json" forHTTPRequestHeader:@"Accept"];
    
    [manager GETUser:self.baseURL userId:@"7" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
- (IBAction)deleteUser:(id)sender {

    // this method will require Administrator credentials
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    [manager DELETEUser:self.baseURL
                 userId:@"122"
                success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Delete");
    }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

}
- (IBAction)patchNode:(id)sender {
    
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"field_tag":@[@{@"target_id":@"2"}],@"body":@[@{@"value":@" Hey I have updated this node via drupal 8 ios kit ",@"format":@"full_html"}],@"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]};
    
    [manager PATCHNode:self.baseURL bundleType:@"tip" nodeId:@"61" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"UPDATED !");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
}
- (IBAction)postUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    
    NSDictionary *parameters = @{@"name":@[@{@"value":@"Dr8Test"}],@"mail":@[@{@"value":@"someunique@gmail.com"}],
                                 @"pass":@[@{@"value":@"New@123"}]};
    
    [manager POSTUser:self.baseURL
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"User Created");
    }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
}
- (IBAction)patchUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters = @{@"name":@[@{@"value":@"Dr8Testing"}],@"mail":@[@{@"value":@"some1unique@gmail.com"}],
                                 @"pass":@[@{@"value":@"New@123"}]};
    
    [manager PATCHUser:self.baseURL userId:@"181" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"User UPDATED !");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
- (IBAction)postArticle:(id)sender {
    
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"body":@[@{@"value":@"New Article first time with REST API ",@"format":@"full_html"}],@"title":@[@{@"value":@"Article Via Drupal 8 iOS sdk"}]};
    
    
    [manager POSTNode:self.baseURL
           bundleType:@"article"
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSLog(@"OK POSTED");
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"%@",error.description);
              }];
    
}
- (IBAction)postComment:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
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
    
}
- (IBAction)getComment:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    [manager setValue:@"application/json" forHTTPRequestHeader:@"Accept"];
    [manager GETCommment:self.baseURL
               commentId:@"6"
              parameters:nil
                 success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
}
- (IBAction)patchComment:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
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

    
}
- (IBAction)deleteComment:(id)sender {
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    [manager DELETEComment:self.baseURL
                 commentId:@"12"
                   success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Comment deleted !");
    }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

    
    
}
- (IBAction)demoDownload:(id)sender {
    
    // to download a file from drupal web site, direct file URL is needed
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/dr8a13/sites/default/files/field/image/profile.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    
    [downloadTask resume];
}

@end
