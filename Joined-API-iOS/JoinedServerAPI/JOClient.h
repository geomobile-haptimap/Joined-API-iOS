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

typedef void (^WebServiceSuccessBlock)(void);
typedef void (^UserWebServiceSuccessBlock)(JOUser *user);
typedef void (^FriendsWebServiceSuccessBlock)(NSArray *friends);

@interface JOClient : NSObject

@property (atomic, strong) NSString* joinedServerUrl;
@property (atomic, strong) NSString* joinedApiKey;

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey;

/** This class demonstrates AppleDoc.
 
 A second paragraph comes after an empty line.
 
    int i=0;
    i++;
 
 And some sample code can also be in a block, but indented with a TAB.
 */
- (void) registerUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) deleteUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) logoutUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) getFriends:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

@end
