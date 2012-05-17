//
//  JOClient.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "JOUser.h"
#import "JOFriend.h"
#import "JOMessage.h"

typedef void (^WebServiceFailedBlock)(NSError *error);

typedef void (^WebServiceSuccessBlock)(void);
typedef void (^UserWebServiceSuccessBlock)(JOUser *user);
typedef void (^FriendsWebServiceSuccessBlock)(NSArray *friends);
typedef void (^MessagesWebServiceSuccessBlock)(NSArray *messages);

/** This class demonstrates AppleDoc.
 
 A second paragraph comes after an empty line.
 
    int i=0;
    i++;
 
 And some sample code can also be in a block, but indented with a TAB.
 */

@interface JOClient : NSObject

@property (atomic, strong) NSString* joinedServerUrl;
@property (atomic, strong) NSString* joinedApiKey;

/** This method ...
 
 The following examples shows ...
 
    int i=0;
    i++;
 
 An example application of this method can be found in class Joined_API_iOSTests. 
 */

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey;

- (void) registerUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) deleteUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) logoutUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) updatePosition:(CLLocationCoordinate2D)position forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) updateStatus:(BOOL)status forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) searchFriendsWithNickname:(NSString*)nickname forUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) addFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) acceptFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) getFriendsForUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) deleteFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) sendMessage:(NSString*)message fromUser:(JOUser*)user toFriend:(JOFriend*)friend success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) getMessageForUser:(JOUser*)user success:(MessagesWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

- (void) deleteMessageForUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

@end
