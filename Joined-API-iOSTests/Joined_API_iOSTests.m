//
//  Joined_API_iOSTests.m
//  Joined-API-iOSTests
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "Joined_API_iOSTests.h"

#import "JOClient.h"

@implementation Joined_API_iOSTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/**
 * This method ...
 */
- (void)testLogin
{
    /* LOGIN USER */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    NSString* username = @"b.baranski"; 
    NSString* password = @"b.baranski";
    
    JOUser *userLogin = nil;
    
    [client loginUser:username andPassword:password success:^(JOUser *user) 
    {  
        STFail(@"Login failed");        
    } failed:^(NSError *error) 
    {
        STFail(@"Login failed");
    } ];
    
    [NSThread sleepForTimeInterval:10.00];  
}

@end
