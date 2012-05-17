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

/** This class contains various methods for accessing the Joined server.
 
 */

@interface JOClient : NSObject

@property (atomic, strong) NSString* joinedServerUrl;
@property (atomic, strong) NSString* joinedApiKey;

/** This method creates a client for the Joined server.
 
 @param joinedServerUrl The URL of the Joined Server.
 @param joinedApiKey The API key for the Joined API for iOS.

 */

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey;

/** This method creates a new user at the Joined server.
 
  @param username The name for the new user.
  @param password The password for the new user.
 
 */

- (void) registerUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method deletes an existing user at the Joined server.
 
  @param user The class JOUser object that represents the logged in user. 
 
 */

- (void) deleteUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method enables users to login at the Joined server.
 
  @param username The name of the user.
  @param password The password of the user.
 
 */

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method enables users to logout at the Joined server.
 
 @param user The class JOUser object that represents the logged in user.
 
 */

- (void) logoutUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This methods updates the position of the user at the Joined server.
 
 @param user The class JOUser object that represents the logged in user.
 @param position The position of the user.
  
 */

- (void) updatePosition:(CLLocationCoordinate2D)position forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method updates the status of the user at the Joined server.

  @param user The class JOUser object that represents the logged in user.
  @param status The status of the user (<code>true</code> for active and visible, <code>false</code> for inactive and invisible).
 
 */

- (void) updateStatus:(BOOL)status forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method searches other users at the Joined server.
 
  @param user The class JOUser object that represents the logged in user.
  @param nickname The nickname other users.
 
 */

- (void) searchFriendsWithNickname:(NSString*)nickname forUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method sends a friends invitation to another user. If the other user accepts the invitation, the user appears at the list of friends. 
 
  @param user The class JOUser object that represents the logged in user.
  @param friend The class JOFriend object that represents the other user.
 
 */

- (void) addFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/**
 
This method accepts the friend invitation of another user.
 
  @param user The class JOUser object that represents the logged in user.
  @param friend The class JOFriend object that represents the other user.
 
 */

- (void) acceptFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method get the friends of an user from the Joined server.
 
  @param user The class JOUser object that represents the logged in user.
 
 */

- (void) getFriendsForUser:(JOUser*)user success:(FriendsWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method deletes a friend from the list of friends.
 
  @param user The class JOUser object that represents the logged in user.
  @param friend The class JOUser object that represents the other user.
  
 */

- (void) deleteFriend:(JOFriend*)friend forUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method sends a text message to a friend.
 
  @param user The class JOUser object that represents the logged in user.
  @param friend The class JOFriend object that represents the friend.
  @param message The text message.
 
 */

- (void) sendMessage:(NSString*)message fromUser:(JOUser*)user toFriend:(JOFriend*)friend success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method returns a list of all available message from the inbox of the logged in user.
 
  @param user The class JOUser object that represents the logged in user.
 
 */

- (void) getMessageForUser:(JOUser*)user success:(MessagesWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

/** This method deletes all messages in the inbox of the logged in user.
 
  @param user The class JOUser object that represents the logged in user.
 
 */

- (void) deleteMessageForUser:(JOUser*)user success:(WebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

@end
