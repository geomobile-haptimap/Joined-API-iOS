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

@synthesize client = _client;

BOOL joinedWorkflowComplete = NO;

BOOL joinedCleanupComplete1 = NO;
BOOL joinedCleanupComplete2 = NO;

BOOL joinedRegistrationComplete1 = NO;
BOOL joinedRegistrationComplete2 = NO;

BOOL joinedLoginComplete1 = NO;
BOOL joinedLoginComplete2 = NO;

BOOL joinedUpdatePositionComplete1 = NO;
BOOL joinedUpdatePositionComplete2 = NO;

BOOL joinedUpdateStatusComplete1 = NO;
BOOL joinedUpdateStatusComplete2 = NO;

BOOL joinedSearchFriendComplete = NO;

BOOL joinedInviteFriendComplete = NO;

BOOL joinedAcceptFriendComplete = NO;

BOOL joinedSendMessageComplete = NO;

BOOL joinedGetMessagesComplete = NO;

BOOL joinedDeleteMessagesComplete = NO;

JOUser* user1;
JOUser* user2;

JOFriend* friend1;
JOFriend* friend2;

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
    self.client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    joinedWorkflowComplete = NO;
    
    [self joinedWorkflowCleanup];
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedWorkflowComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

/**
 * This method ...
 */
- (void) joinedWorkflowCleanup
{
    joinedCleanupComplete1 = NO;
    joinedCleanupComplete2 = NO;    
    
    /* DELETE USER 1 */
    [self.client loginUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
    {
        [self.client deleteUser:user success:^(void) 
        {  
            joinedCleanupComplete1 = YES;
        } failed:^(NSError *error) 
        {
            joinedCleanupComplete1 = YES;            
        } ];         
    } failed:^(NSError *error) 
    {
        joinedCleanupComplete1 = YES;        
    } ];
    
    /* DELETE USER 2 */
    [self.client loginUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
     {
         [self.client deleteUser:user success:^(void) 
          {  
              joinedCleanupComplete2 = YES;
          } failed:^(NSError *error) 
          {
              joinedCleanupComplete2 = YES;            
          } ];         
     } failed:^(NSError *error) 
     {
         joinedCleanupComplete2 = YES;        
     } ];
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedCleanupComplete1 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    while (!joinedCleanupComplete2 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self joinedWorkflowRegistration];
}


/**
 * This method ...
 */
- (void) joinedWorkflowRegistration
{
    joinedRegistrationComplete1 = NO;
    joinedRegistrationComplete2 = NO;    
    
    /* REGISTER USER 1 */
    [self.client registerUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
    {  
        joinedRegistrationComplete1 = YES;
    } failed:^(NSError *error) 
    {
        STFail(@"Registration Failed");
        joinedWorkflowComplete = YES;
    } ];
    
    /* REGISTER USER 2 */
    [self.client registerUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
     {  
         joinedRegistrationComplete2 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Registration Failed");
         joinedWorkflowComplete = YES;
     } ];
 
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedRegistrationComplete1 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    while (!joinedRegistrationComplete2 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    [self joinedWorkflowLogin];
}


/**
 * This method ...
 */
- (void) joinedWorkflowLogin
{
    joinedLoginComplete1 = NO;
    joinedLoginComplete2 = NO;
    
    /* LOGIN USER 1 */
    [self.client loginUser:TEST_USER_1 andPassword:TEST_USER_1 success:^(JOUser *user) 
     {  
         user1 = user;
         joinedLoginComplete1 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Login Failed");
         joinedWorkflowComplete = YES;
     } ];
    
    /* LOGIN USER 1 */
    [self.client loginUser:TEST_USER_2 andPassword:TEST_USER_2 success:^(JOUser *user) 
     {  
         user2 = user;
         joinedLoginComplete2 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Login Failed");
         joinedWorkflowComplete = YES;
     } ];  
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedLoginComplete1 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    while (!joinedLoginComplete2 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    [self joinedWorkflowUpdateStatus];
}

- (void) joinedWorkflowUpdateStatus
{
    joinedUpdateStatusComplete1 = NO;
    joinedUpdateStatusComplete2 = NO;
    
    /* UPDATE STATUS FOR USER 1 */
    [self.client updateStatus:YES forUser:user1 success:^(void) 
     {  
         joinedUpdateStatusComplete1 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Update Status Failed");
         joinedWorkflowComplete = YES;
     } ];
    
    /* UPDATE STATUS FOR USER 1 */
    [self.client updateStatus:YES forUser:user2 success:^(void) 
     {  
         joinedUpdateStatusComplete2 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Update Status Failed");
         joinedWorkflowComplete = YES;
     } ];

    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedUpdateStatusComplete1 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    while (!joinedUpdateStatusComplete2 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    [self joinedWorkflowUpdatePosition];
}

- (void) joinedWorkflowUpdatePosition
{
    joinedUpdatePositionComplete1 = NO;
    joinedUpdatePositionComplete2 = NO;
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(23.4, 12.3);
    
    /* UPDATE STATUS FOR USER 1 */
    [self.client updatePosition:location forUser:user1 success:^(void) 
     {  
         joinedUpdatePositionComplete1 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Update Position Failed");
         joinedWorkflowComplete = YES;
     } ];
    
    /* UPDATE STATUS FOR USER 1 */
    [self.client updatePosition:location forUser:user2 success:^(void) 
     {  
         joinedUpdatePositionComplete2 = YES;
     } failed:^(NSError *error) 
     {
         STFail(@"Update Position Failed");
         joinedWorkflowComplete = YES;
     } ];
    
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedUpdatePositionComplete1 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    while (!joinedUpdatePositionComplete2 && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    [self joinedWorkflowInviteFriend];
}

- (void) joinedWorkflowInviteFriend
{
    joinedSearchFriendComplete = NO;
    joinedInviteFriendComplete = NO;

    [self.client searchFriendsWithNickname:TEST_USER_2 forUser:user1 success:^(NSArray *friends) 
     {  
        if (friends.count != 1)
        {
            STFail(@"Search Friend Failed");
            joinedWorkflowComplete = YES;            
        }
        
        friend2 = [friends objectAtIndex:0];
        
        if (friend2.friendshipStatus.intValue != FRIEND_STATUS_NO)
        {
            STFail(@"Search Friend Failed");
            joinedWorkflowComplete = YES;                        
        }
      
        joinedSearchFriendComplete = YES;
    } failed:^(NSError *error) 
    {
        STFail(@"Login Failed");
        joinedWorkflowComplete = YES;
    } ];
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedSearchFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self.client addFriend:friend2 forUser:user1 success:^
     {    
         joinedInviteFriendComplete = YES;
     } failed:^(NSError *error) 
     {
        joinedWorkflowComplete = YES;
     } ];

    
    while (!joinedInviteFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    [self joinedWorkflowAcceptFriend];
}

- (void) joinedWorkflowAcceptFriend
{
    joinedSearchFriendComplete = NO;
    joinedAcceptFriendComplete = NO;
    
    [self.client getFriendsForUser:user2 success:^(NSArray *friends) 
    {
        if (friends.count != 1)
        {
            STFail(@"Search Friend Failed");
            joinedWorkflowComplete = YES;            
        }
        
        friend1 = [friends objectAtIndex:0];
        
        if (friend1.friendshipStatus.intValue != FRIEND_STATUS_NO)
        {
            STFail(@"Search Friend Failed");
            joinedWorkflowComplete = YES;                        
        }
        
        joinedSearchFriendComplete = YES;
    } failed:^(NSError *error) {
        STFail(@"Search Friends Failed");
        joinedWorkflowComplete = YES;        
    } ];
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedSearchFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    
    [self.client acceptFriend:friend1 forUser:user2 success:^
     {
         joinedAcceptFriendComplete = YES;
         
     } failed:^(NSError *error) 
     {
         STFail(@"Accept Friends Failed");
         joinedWorkflowComplete = YES;
     } ];
    
    while (!joinedAcceptFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);    
    
    joinedSearchFriendComplete = NO;
    
    [self.client getFriendsForUser:user2 success:^(NSArray *friends) 
     {
         if (friends.count != 1)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;            
         }
         
         friend1 = [friends objectAtIndex:0];
         
         if (friend1.friendshipStatus.intValue != FRIEND_STATUS_YES)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;                        
         }
         
         joinedSearchFriendComplete = YES;
     } failed:^(NSError *error) {
         STFail(@"Search Friends Failed");
         joinedWorkflowComplete = YES;        
     } ];
    
    while (!joinedSearchFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self joinedWorkflowSendMessage];
}

- (void) joinedWorkflowSendMessage
{
    joinedSearchFriendComplete = NO;
    joinedSendMessageComplete = NO;
    
    [self.client getFriendsForUser:user1 success:^(NSArray *friends) 
     {
         if (friends.count != 1)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;            
         }
         
         friend1 = [friends objectAtIndex:0];
         
         if (friend1.friendshipStatus.intValue != FRIEND_STATUS_YES)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;                        
         }
         
         joinedSearchFriendComplete = YES;
     } failed:^(NSError *error) {
         STFail(@"Search Friends Failed");
         joinedWorkflowComplete = YES;        
     } ];    
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedSearchFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self.client sendMessage:@"Hello" fromUser:user1 toFriend:friend1 success:^
    {
        joinedSendMessageComplete = YES;
        
    } failed:^(NSError *error)
    {
        STFail(@"Send Message Failed");
        joinedWorkflowComplete = YES;        

    }  ];
    
    while (!joinedSendMessageComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    joinedSendMessageComplete = NO;
    
    [self.client sendMessage:@"World" fromUser:user1 toFriend:friend1 success:^
     {
         joinedSendMessageComplete = YES;
         
     } failed:^(NSError *error)
     {
         STFail(@"Send Message Failed");
         joinedWorkflowComplete = YES;        
         
     }  ];
    
    while (!joinedSendMessageComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self joinedWorkflowGetMessages];
}

- (void) joinedWorkflowGetMessages
{
    joinedSearchFriendComplete = NO;
    joinedGetMessagesComplete = NO;
    
    [self.client getFriendsForUser:user2 success:^(NSArray *friends) 
     {
         if (friends.count != 1)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;            
         }
         
         friend2 = [friends objectAtIndex:0];
         
         if (friend2.friendshipStatus.intValue != FRIEND_STATUS_YES)
         {
             STFail(@"Search Friend Failed");
             joinedWorkflowComplete = YES;                        
         }
         
         joinedSearchFriendComplete = YES;
     } failed:^(NSError *error) {
         STFail(@"Search Friends Failed");
         joinedWorkflowComplete = YES;        
     } ];    
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedSearchFriendComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self.client getMessageForUser:user2 success:^(NSArray *messages) 
    {
        if (messages.count != 2)
        {
            STFail(@"Search Messages Failed");
            joinedWorkflowComplete = YES;            
        }
        
        JOMessage *message1 = [messages objectAtIndex:0];
        JOMessage *message2 = [messages objectAtIndex:1];

        if (![message1.content isEqualToString:@"Hello"])
        {
            STFail(@"Search Messages Failed");
            joinedWorkflowComplete = YES;                        
        }
        
        if (![message2.content isEqualToString:@"World"])
        {
            STFail(@"Search Messages Failed");
            joinedWorkflowComplete = YES;                        
        }        
        
        joinedGetMessagesComplete = YES;
        
    } failed:^(NSError *error)
    {
        STFail(@"Get Messages Failed");
        joinedWorkflowComplete = YES;        

    } ];
    
    while (!joinedGetMessagesComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    [self joinedDeleteMessages];
}

- (void) joinedDeleteMessages
{
    joinedSearchFriendComplete = NO;
    joinedDeleteMessagesComplete = NO;
    
    [self.client deleteMessageForUser:user2 success:^
    {
        joinedDeleteMessagesComplete = YES;        
    } failed:^(NSError *error) 
    {    
        STFail(@"Delete Messages Failed");
        joinedWorkflowComplete = YES;        
        
    } ];
                       
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];    
    while (!joinedDeleteMessagesComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    joinedWorkflowComplete = YES; 
}

@end
