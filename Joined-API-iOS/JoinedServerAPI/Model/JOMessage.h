//
//  JOMessage.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 15.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JOMessage : NSObject

@property (atomic, strong) NSString* messageId;
@property (atomic, strong) NSString* senderId;
@property (atomic, strong) NSNumber* direction;
@property (atomic, strong) NSString* content;
@property (atomic, strong) NSNumber* time;

- (id) initWithJSON:(NSDictionary*) jsonData;

@end
