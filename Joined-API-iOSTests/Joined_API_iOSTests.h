//
//  Joined_API_iOSTests.h
//  Joined-API-iOSTests
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "JOClient.h"

@interface Joined_API_iOSTests : SenTestCase

@property (atomic, strong) JOClient* client;

- (void) joinedWorkflowCleanup;

- (void) joinedWorkflowRegistration;

- (void) joinedWorkflowLogin;

- (void) joinedWorkflowLogout;

- (void) joinedWorkflowUpdatePosition;

- (void) joinedWorkflowUpdateStatus;

- (void) joinedWorkflowInviteFriend;

- (void) joinedWorkflowAcceptFriend;

- (void) joinedWorkflowSendMessage;

- (void) joinedWorkflowGetMessages;

@end
