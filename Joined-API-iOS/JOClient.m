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
#import "JOFriend.h"

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
    
    AFJSONRequestOperation* operation = [JSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);
        
        JOUser* user = [[JOUser alloc] initWithJSON:responseObject];
        successBlock(user);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);
        
        JOUser* user = [[JOUser alloc] initWithJSON:responseObject];
        successBlock(user);  
    } ];

    [operation start];
}

- (void) getFriends:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
 
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, FRIENDS];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];

    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);     
        
        NSMutableArray* friendList = [[NSMutableArray alloc] init];
        
        NSDictionary* json = responseObject;
        
        NSEnumerator *enumerator = [json objectEnumerator];
        id obj;
        while (obj = [enumerator nextObject] ) 
        {
            // NSDictionary* friend = responseObject;
            
            JOFriend* friend = [[JOFriend alloc] initWithJSON:obj];
            [friendList addObject:friend];            
        }

        successBlock(friendList);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"failure Error %@", error);    

        failedBlock(error);
    } ];
       
    [operation start];
}

@end
