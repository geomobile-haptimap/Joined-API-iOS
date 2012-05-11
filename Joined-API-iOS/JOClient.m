//
//  JOClient.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOClient.h"

#import "JoinedHTTPClient.h"
#import "NSString+easyHash.h"
#import "JSONRequestOperation.h"

@implementation JOClient

@synthesize joinedServerUrl = _joinedServerUrl;
@synthesize joinedApiKey = _joinedApiKey;

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey
{
    self = [super init];
    self.joinedServerUrl = joinedServerUrl;
    self.joinedApiKey = joinedApiKey;
    return self;
}

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSString *passwordHash = [[password stringByAppendingString:username] sha1];    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, NICKNAME,
                            passwordHash, PASSWORD,
                            nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_LOGIN, self.joinedApiKey];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSMutableURLRequest *request = [httpClient  requestWithMethod:@"POST" path:path parameters:parameters];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
//    void (^requestSuccess)(NSURLRequest*, NSHTTPURLResponse*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) 
//    {
//        NSLog(@"success JSON %@", JSON);
//        JOUser* user = [[JOUser alloc] initWithJSON:JSON];
//    };
//    
//    void (^requestFailure)(NSURLRequest*, NSHTTPURLResponse*, NSError*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        NSLog(@"failure Error %@", error);
//    };

    
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) 
    {
        NSLog(@"success JSON %@", [operation responseData]);
        JOUser* user = [[JOUser alloc] initWithJSON:[operation responseData]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) 
    {
        NSLog(@"failure Error %@", error);
    }];

//    AFJSONRequestOperation *operation = [JSONRequestOperation 
//                                         JSONRequestOperationWithRequest:request 
//                                         success:requestSuccess
//                                         failure:requestFailure];

    [operation start];
}

@end
