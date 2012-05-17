//
//  JOFriend.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class contains various methods for receiving information about a user.
 
 */

@interface JOFriend : NSObject

/** This property is the nickname of the friend.
 
 */

@property (atomic, strong) NSString* nickname;

/** This property is the time point of the last position update of the friend.
 
 */

@property (atomic, strong) NSNumber* lastPosUpdate;

/** This property is the current friendship status of the friend.
 
 */

@property (atomic, strong) NSNumber* friendshipStatus;

/** This property is the avatar image of the friend.
 
 */

@property (atomic, strong) NSString* image;

/** This property is the avatar image of the friend.
 
 */

@property (atomic, strong) NSString* imageHash;

/** This property is the last known position (latitude) of the friend.
 
 */

@property (atomic, strong) NSNumber* latitude;

/** This property is the last known position (longitude) of the friend.
 
 */

@property (atomic, strong) NSNumber* longitude;

/** This property is the identifier of the friend.
 
 */

@property (atomic, strong) NSString* userId;

/** This property is the current status of the friend.
 
 */

@property BOOL isActive;

/** This property is the identifier of the friend.
 
 */

@property (atomic, strong) NSString* facebookId;

/** This methods creates a friend object from a JSON string.
 
 */

- (id) initWithJSON:(NSDictionary*) jsonData;


@end
