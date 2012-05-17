//
//  JOMessage.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 15.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class contains various methods for receiving information about a message.
 
 */

@interface JOMessage : NSObject

/** This property is the identifier of the message.
 
 */

@property (atomic, strong) NSString* messageId;

/** This property is the identifier of the sender of the message.
 
 */

@property (atomic, strong) NSString* senderId;

/** This property is the sending direction of the message.
 
 */

@property (atomic, strong) NSNumber* direction;

/** This property is the content of the message.
 
 */

@property (atomic, strong) NSString* content;

/** This property is the sending time point of the message.
 
 */

@property (atomic, strong) NSNumber* time;

/** This methods creates a message object from a JSON string.
 
 */

- (id) initWithJSON:(NSDictionary*) jsonData;

@end
