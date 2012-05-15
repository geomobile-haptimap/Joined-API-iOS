//
//  Joined_API_iOSTests.h
//  Joined-API-iOSTests
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "JOUser.h"

@interface Joined_API_iOSTests : SenTestCase

- (void) joinedWorkflowCleanupUser1;

- (void) joinedWorkflowRegistrationUser1;
- (void) joinedWorkflowRegistrationUser2;

- (void) joinedWorkflowLoginUser1;
- (void) joinedWorkflowLoginUser2;

- (void) joinedWorkflowLogoutUser1:(JOUser*) user;
- (void) joinedWorkflowLogoutUser2:(JOUser*) user;

@end
