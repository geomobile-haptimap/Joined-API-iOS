//
//  JOUser.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class contains various methods for receiving information about a user.
 
 */

@interface JOUser : NSObject

/** This property is the identifier of the user.
 
 */

@property (atomic, strong) NSString* userId;

/** This property is the secure token of the user.
 
 */

@property (atomic, strong) NSString* userSecureToken;

/** This methods creates a user object from a JSON string.
 
 */

- (id) initWithJSON:(NSDictionary*) json;

@end
