//
//  JOUser.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JOUser : NSObject

@property (atomic, strong) NSString* userId;
@property (atomic, strong) NSString* userSecureToken;

- (id) initWithJSON:(NSDictionary*) json;

@end
