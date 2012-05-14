//
//  JOFriend.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JOFriend : NSObject

@property (atomic, strong) NSString* nickname;
@property (atomic, strong) NSNumber* lastPosUpdate;
@property (atomic, strong) NSNumber* friendshipStatus;
@property (atomic, strong) NSString* image;
@property (atomic, strong) NSString* imageHash;
@property (atomic, strong) NSNumber* latitude;
@property (atomic, strong) NSNumber* longitude;
@property (atomic, strong) NSString* userId;
@property BOOL isActive;
@property (atomic, strong) NSString* facebookId;

- (id) initWithJSON:(NSDictionary*) jsonData;


@end
