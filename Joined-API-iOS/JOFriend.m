//
//  JOFriend.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOFriend.h"

@implementation JOFriend

@synthesize nickname = _nickname;
@synthesize lastPosUpdate = _lastPosUpdate;
@synthesize friendshipStatus = _friendshipStatus;
@synthesize image = _image;
@synthesize imageHash = _imageHash;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize userId = _userId;
@synthesize isActive = _isActive;
@synthesize facebookId = _facebookId;

- (id) initWithJSON:(NSDictionary*) json
{
    self = [super init];
       
    NSString* jsonNickname = [json objectForKey:NICKNAME];
    self.nickname = jsonNickname;
    
    NSNumber* jsonLastPosUpdate = [json objectForKey:LAST_POS_UPDATE];
    self.lastPosUpdate = jsonLastPosUpdate;
    
    NSNumber* jsonFriendshipStatus = [json objectForKey:STATUS];
    self.friendshipStatus = jsonFriendshipStatus;
    
    //NSString* jsonImage;
    //NSString* jsonImageHash;
    
    NSNumber* jsonLatitude = [json objectForKey:LATITUDE];
    self.latitude = jsonLatitude;
    
    NSNumber* jsonLongitude = [json objectForKey:LONGITUDE];
    self.longitude = jsonLongitude;
    
    NSString* jsonUserId = [json objectForKey:ID];
    self.userId = jsonUserId;
    
    return self;   
}

@end
