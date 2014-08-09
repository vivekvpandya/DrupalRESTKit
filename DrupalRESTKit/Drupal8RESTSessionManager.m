//
//  Drupal8RESTSessionManager.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.

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

#import "Drupal8RESTSessionManager.h"

@implementation Drupal8RESTSessionManager


-(AFHTTPSessionManager *)sessionManager{
    
    if (!_sessionManager ) {
        _sessionManager = [AFHTTPSessionManager manager];// A singleton AFHTTPSessionManager object will be returned.
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/hal+json"];
        
    }
    
 
    
    return _sessionManager;

}

#pragma mark configuration methods implementation for SessionManagerObject

-(void)setValue:(NSString *)value forHTTPRequestHeader:(NSString *)header{

    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:header];
    
}

-(void)clearAuthorizationHeader{
    
    [self.sessionManager.requestSerializer clearAuthorizationHeader];

}

#pragma mark CRUD methods for  Entity - implementation

-(NSURLSessionDataTask *)POSTEntity:(NSString *)url
                         parameters:(id)parameters
                            success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{


    NSURLSessionDataTask *postEntityTask = [self.sessionManager POST:url
                                                          parameters:parameters
                                                             success:success
                                                             failure:failure];
    
    return postEntityTask;
    
    
}



-(NSURLSessionDataTask *)GETEntity:(NSString *)url
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *getEntityTask = [self.sessionManager GET:url
                                                        parameters:parameters
                                                           success:success
                                                           failure:failure];
    return getEntityTask;
    
}


-(NSURLSessionDataTask *)PATCHEntity:(NSString *)url
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *patchEntityTask = [self.sessionManager PATCH:url
                                                            parameters:parameters
                                                               success:success
                                                               failure:failure];
    return patchEntityTask;
}


-(NSURLSessionDataTask *)DELETEEntity:(NSString *)url
                           parameters:(id)parameters
                              success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                              failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *deleteEntityTask = [self.sessionManager DELETE:url
                                                              parameters:parameters
                                                                 success:success
                                                                 failure:failure];
    return deleteEntityTask;
    
}


#pragma mark CRUD methods for node - implementation


-(NSURLSessionDataTask *)POSTNode:(NSString *)url
                       bundleType:(NSString *)bundleType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    

    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
  
    
    NSString *nodeRESTEndpointURL = [NSString stringWithFormat:@"%@/entity/node",url];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/node/%@",url,bundleType];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *postNodeTask = [self POSTEntity:nodeRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return postNodeTask;
}

-(NSURLSessionDataTask *)DELETENode:(NSString *)url
                             nodeId:(NSString *)nid
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    NSString *deleteRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
    NSURLSessionDataTask *deleteNodeTask = [self DELETEEntity:deleteRESTEndpointURL
                                                   parameters:nil
                                                      success:success
                                                      failure:failure];
    return deleteNodeTask;
    

}

-(NSURLSessionDataTask *)GETNode:(NSString *)url
                          nodeId:(NSString *)nid
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    
    
     NSString *getRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
  
    
    NSURLSessionDataTask *getNodeTask = [self GETEntity:getRESTEndpointURL parameters:nil success:success failure:failure];
    
    return getNodeTask;


}

-(NSURLSessionDataTask *)PATCHNode:(NSString *)url
                        bundleType:(NSString *)bundleType
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *, id))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *nodeRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/node/%@",url,bundleType];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *patchNodeTask = [self PATCHEntity:nodeRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return patchNodeTask;

    

}

#pragma mark GET method for View - implementation

-(NSURLSessionDataTask *)GETView:(NSString *)url
                        viewName:(NSString *)viewName
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    
    NSString *viewURL = [NSString stringWithFormat:@"%@/%@",url,viewName];
  
    NSURLSessionDataTask *getViewDataTask = [self.sessionManager GET:viewURL
                                                          parameters:parameters
                                                             success:success failure:failure];
    
    return getViewDataTask;
    


}

#pragma mark CRUD methods for User - implementation

-(NSURLSessionDataTask *)GETUser:(NSString *)url
                          userId:(NSString *)uid
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *getRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    
    
    NSURLSessionDataTask *getUserTask = [self GETEntity:getRESTEndpointURL
                                             parameters:nil
                                                success:success
                                                failure:failure];
    
    return getUserTask;


}

-(NSURLSessionDataTask *)DELETEUser:(NSString *)url
                             userId:(NSString *)uid
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *deleteRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    NSURLSessionDataTask *deleteUserTask =[self DELETEEntity:deleteRESTEndpointURL
                                                   parameters:nil
                                                      success:success
                                                      failure:failure];
    return deleteUserTask;
    
}

-(NSURLSessionDataTask *)POSTUser:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *userRESTEndpointURL = [NSString stringWithFormat:@"%@/entity/user",url];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/user/user",url];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *postUserTask = [self POSTEntity:userRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return postUserTask;


}

-(NSURLSessionDataTask *)PATCHUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *, id))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *userRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/user/user",url];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *patchUserTask = [self PATCHEntity:userRESTEndpointURL
                                                 parameters:requestBody
                                                    success:success
                                                    failure:failure];
    return patchUserTask;
    


}

#pragma mark CRUD methods for comments - implementataion

-(NSURLSessionDataTask *)GETCommment:(NSString *)url
                           commentId:(NSString *)cid
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *, id))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    NSString *getRESTEndpoint = [NSString stringWithFormat:@"%@/comment/%@",url,cid];
    NSURLSessionDataTask *getCommentTask = [self GETEntity:getRESTEndpoint
                                                parameters:nil
                                                   success:success
                                                   failure:failure];
    return getCommentTask;
    
}

-(NSURLSessionDataTask *)PATCHCommment:(NSString *)url
                             commentId:(NSString *)cid
                            parameters:(id)parameters
                               success:(void (^)(NSURLSessionDataTask *, id))success
                               failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    
  //  NSString *relationKey = [NSString stringWithFormat:@"%@/rest/relation/comment/node__comment/entity_id",url];
   // NSString *relationValue = [NSString stringWithFormat:@"%@/node/%@",url,entityID];
    
    
    
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *patchRESTEndpoint = [NSString stringWithFormat:@"%@/comment/%@",url,cid];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/comment/node__comment",url];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *patchCommentTask = [self PATCHEntity:patchRESTEndpoint
                                                 parameters:requestBody
                                                    success:success
                                                    failure:failure];
    return patchCommentTask;


    

}

-(NSURLSessionDataTask *)POSTComment:(NSString *)url
                      targetEntityId:(NSString *)entityID
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *, id))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *postRESTEndpoint = [NSString stringWithFormat:@"%@/entity/comment",url];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/comment/node__comment",url];
    
    NSString *relationKey = [NSString stringWithFormat:@"%@/rest/relation/comment/node__comment/entity_id",url];
    NSString *relationValue = [NSString stringWithFormat:@"%@/node/%@",url,entityID];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType},relationKey:relationValue},@"entity_id":@[@{@"target_id":entityID,@"revision_id":@""}]}];
    
    
    
    
    NSURLSessionDataTask *postCommentTask = [self POSTEntity:postRESTEndpoint
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return postCommentTask;
}

-(NSURLSessionDataTask *)DELETEComment:(NSString *)url
                             commentId:(NSString *)cid
                               success:(void (^)(NSURLSessionDataTask *, id))success
                               failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    NSString *deleteRESTEndpoint = [NSString stringWithFormat:@"%@/comment/%@",url,cid];
    NSURLSessionDataTask *deleteCommentTask = [self DELETEEntity:deleteRESTEndpoint
                                                parameters:nil
                                                   success:success
                                                   failure:failure];
    return  deleteCommentTask;

}


@end
