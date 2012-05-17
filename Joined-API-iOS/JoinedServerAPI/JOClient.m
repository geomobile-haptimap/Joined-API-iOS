//
//  JOClient.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOClient.h"

#import "JOJoinedHTTPClient.h"
#import "JONSString+easyHash.h"
#import "JOJSONRequestOperation.h"
#import "JOFriend.h"
#import "JONSString+URLEncoding.h"

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

- (void) registerUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSString *passwordHash = [[password stringByAppendingString:username] sha1];    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                username, NICKNAME,
                                passwordHash, PASSWORD,
                                nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_REGISTER, self.joinedApiKey];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        JOUser* user = [[JOUser alloc] initWithJSON:responseObject];
        successBlock(user);

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) deleteUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_FRIENDS, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        successBlock();
     
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSString *passwordHash = [[password stringByAppendingString:username] sha1];    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, NICKNAME,
                            passwordHash, PASSWORD,
                            [NSNumber numberWithBool:YES], IS_ACTIVE,
                            nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_LOGIN, self.joinedApiKey];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSMutableURLRequest *request = [httpClient  requestWithMethod:@"POST" path:path parameters:parameters];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        JOUser* user = [[JOUser alloc] initWithJSON:responseObject];
        successBlock(user);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];

    [operation start];
}

- (void) logoutUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:NO], IS_ACTIVE,
                                nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_FRIENDS, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"PUT" path:path parameters:parameters constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
     {
         successBlock();
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
     {
         NSLog(@"Error %@", error);
         failedBlock(error);
     } ];
    
    [operation start];    
}

- (void) updatePosition:(CLLocationCoordinate2D)position forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:position.latitude], LATITUDE,
                                [NSNumber numberWithDouble:position.longitude], LONGITUDE, nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_FRIENDS, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"PUT" path:path parameters:parameters constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
     {
         successBlock();
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
     {
         NSLog(@"Error %@", error);
         failedBlock(error);
     } ];
    
    [operation start];
}

- (void) updateStatus:(BOOL)status forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:status], IS_ACTIVE, nil];
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_FRIENDS, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"PUT" path:path parameters:parameters constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        successBlock();

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) searchFriendsWithNickname:(NSString*)nickname forUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{    
    /* CREATE SERVICE */
 
    NSString *encodedNickname = [nickname urlEncode];
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, SEARCH, encodedNickname];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);     
        
        NSMutableArray* friendList = [[NSMutableArray alloc] init];
        
        NSDictionary* json = responseObject;
        
        NSEnumerator *enumerator = [json objectEnumerator];
        id obj;
        while (obj = [enumerator nextObject] ) 
        {
            JOFriend* friend = [[JOFriend alloc] initWithJSON:obj];
            [friendList addObject:friend];            
        }
        
        successBlock(friendList);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) addFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, FRIEND, friend.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        successBlock();
         
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"Error %@", error);
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) acceptFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, FRIEND, friend.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"PUT" path:path parameters:nil constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
     {
         successBlock();
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
     {
         NSLog(@"Error %@", error);
         failedBlock(error);
     } ];
    
    [operation start];

}

- (void) getFriendsForUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, FRIENDS];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];

    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);     
        
        NSMutableArray* friendList = [[NSMutableArray alloc] init];
        
        NSDictionary* json = responseObject;
        
        NSEnumerator *enumerator = [json objectEnumerator];
        id obj;
        while (obj = [enumerator nextObject] ) 
        {
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

- (void) deleteFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@%@%@", self.joinedServerUrl, FF_FRIENDS, user.userId, FRIEND, friend.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"DELETE" path:path parameters:nil constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        successBlock();
         
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"failure Error %@", error);    
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) sendMessage:(NSString*)message fromUser:(JOUser*)user toFriend:(JOFriend*)friend success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE PARAMETERS*/
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:message, TEXT, nil] ;
    
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@/%@", self.joinedServerUrl, FF_MESSAGE, user.userId, friend.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
     {
         NSLog(@"success JSON %@", responseObject);     
         
         successBlock();
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
     {
         NSLog(@"failure Error %@", error);    
         failedBlock(error);
     } ];
    
    [operation start];
}

- (void) getMessageForUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_MESSAGE, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        NSLog(@"success JSON %@", responseObject);     
     
        NSMutableArray* messageList = [[NSMutableArray alloc] init];
        
        NSDictionary* json = responseObject;
        
        NSEnumerator *enumerator = [json objectEnumerator];
        id obj;
        while (obj = [enumerator nextObject] ) 
        {
            JOMessage* message = [[JOMessage alloc] initWithJSON:obj];
            [messageList addObject:message];            
        }
        
        successBlock(messageList);
     
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"failure Error %@", error);    
        failedBlock(error);
    } ];
    
    [operation start];
}

- (void) deleteMessageForUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock
{
    /* CREATE SERVICE */
    
    NSString *path = [NSString stringWithFormat:@"%@%@/%@", self.joinedServerUrl, FF_MESSAGE, user.userId];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:path]];
    
    [httpClient setAuthorizationHeaderWithUsername:user.userId password:user.userSecureToken];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request.timeoutInterval = 10;
    
    /* EXECUTE SERVICE */
    
    AFJSONRequestOperation* operation = [JOJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject) 
    {
        successBlock();
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject) 
    {
        NSLog(@"failure Error %@", error);    
        failedBlock(error);
    } ];
    
    [operation start];
}

@end
