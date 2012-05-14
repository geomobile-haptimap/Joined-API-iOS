//
//  JOClient.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JOUser.h"

typedef void (^WebServiceFailedBlock)(NSError *error);

typedef void (^UserWebServiceSuccessBlock)(JOUser *user);
typedef void (^FriendsWebServiceSuccessBlock)(NSArray *friends);

@interface JOClient : NSObject

@property (atomic, strong) NSString* joinedServerUrl;
@property (atomic, strong) NSString* joinedApiKey;

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey;

/**
 * This method enables users to login at the Joined server.
 * 
 * @param username The name of the user.
 * @param password The password of the user.
 */
- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) getFriends:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

@end
