//
//  Joined_API_iOSTests.m
//  Joined-API-iOSTests
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <sys/semaphore.h>

#import "Joined_API_iOSTests.h"

#import "JOClient.h"

@implementation Joined_API_iOSTests

BOOL joinedWorkflowComplete = NO;

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
    joinedWorkflowComplete = NO;
    
    [self joinedWorkflowCleanupUser1];
    
    // Begin a run loop terminated when the loginComplete it set to true
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedWorkflowComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

/**
 * This method ...
 */
- (void) joinedWorkflowCleanupUser1
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* LOGIN USER */
    
    [client loginUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
    {
        /* DELETE USER */
        
        [client deleteUser:user success:^(void) 
        {  
            [self joinedWorkflowCleanupUser2];
        } failed:^(NSError *error) 
        {
            [self joinedWorkflowCleanupUser2];
        } ];
         
    } failed:^(NSError *error) 
    {
        [self joinedWorkflowCleanupUser2];
    } ];
}

/**
 * This method ...
 */
- (void) joinedWorkflowCleanupUser2
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* LOGIN USER */
    
    [client loginUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
     {  
         [client deleteUser:user success:^(void) 
          {  
              [self joinedWorkflowRegistrationUser1];
          } failed:^(NSError *error) 
          {
              STFail(@"Cleanup Failed");
              [self joinedWorkflowRegistrationUser1];
          } ];
         
     } failed:^(NSError *error) 
     {
         [self joinedWorkflowRegistrationUser1];
     } ];
}

/**
 * This method ...
 */
- (void) joinedWorkflowRegistrationUser1
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* REGISTER USER */
    
    [client registerUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
     {  
         [self joinedWorkflowRegistrationUser2];
     } failed:^(NSError *error) 
     {
         STFail(@"Registration Failed");
         joinedWorkflowComplete = YES;
     } ];
}

/**
 * This method ...
 */
- (void) joinedWorkflowRegistrationUser2
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* REGISTER USER */
    
    [client registerUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
    {  
        [self joinedWorkflowLoginUser1];
    } failed:^(NSError *error) 
    {
        STFail(@"Registration Failed");
        joinedWorkflowComplete = YES;
    } ];
}

/**
 * This method ...
 */
- (void) joinedWorkflowLoginUser1
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* LOGIN USER */
    
    [client loginUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
     {  
         [self joinedWorkflowLogoutUser1:user];
     } failed:^(NSError *error) 
     {
         STFail(@"Login Failed");
         joinedWorkflowComplete = YES;
     } ];
}

/**
 * This method ...
 */
- (void) joinedWorkflowLogoutUser1:(JOUser*) user
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* LOGIN USER */
    
    [client logoutUser:user success:^(void) 
    {  sdfdsf
        
    } failed:^(NSError *error) 
    {
        STFail(@"Logout Failed");
        joinedWorkflowComplete = YES;
    } ];         
}

/**
 * This method ...
 */
- (void) joinedWorkflowLoginUser2
{
    /* CREATE CLIENT */
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    /* LOGIN USER */
    
    [client loginUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
    {  
        joinedWorkflowComplete = YES;
    } failed:^(NSError *error) 
    {
        STFail(@"Login Failed");
        joinedWorkflowComplete = YES;
    } ];
}


@end
