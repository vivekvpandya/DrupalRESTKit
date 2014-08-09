//
//  Drupal8RESTSessionManager.h
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

#import <Foundation/Foundation.h>

@interface Drupal8RESTSessionManager : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager; // a session manager object that will be shred among all the REST operation.

#pragma configuration methods for SessionManagerObject
-(void)clearAuthorizationHeader;
-(void)setValue:(NSString *)value forHTTPRequestHeader:(NSString *)header;


#pragma mark CRUD for node
-(NSURLSessionDataTask *)GETNode:(NSString *)url
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTNode:(NSString *)url
                       bundleType:(NSString *)bundleType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)PATCHNode:(NSString *)url
                        bundleType:(NSString *)bundleType
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)DELETENode:(NSString *)url
                            nodeId:(NSString *)nid
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma mark  CRUD for user

-(NSURLSessionDataTask *)GETUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTUser:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)PATCHUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)DELETEUser:(NSString *)url
                            userId:(NSString *)uid
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma mark GET method for view

-(NSURLSessionDataTask *)GETView:(NSString *)url
                        viewName:(NSString *)viewName
                      parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma mark CRUD for Comment

-(NSURLSessionDataTask *)GETCommment:(NSString *)url
                           commentId:(NSString *)cid
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
-(NSURLSessionDataTask *)PATCHCommment:(NSString *)url
                           commentId:(NSString *)cid
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTComment:(NSString *)url
                            targetEntityId:(NSString *)entityID
                          parameters:(id)parameters
                             success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
-(NSURLSessionDataTask *)DELETEComment:(NSString *)url
                             commentId:(NSString *)cid
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
