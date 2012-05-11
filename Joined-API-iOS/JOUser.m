//
//  JOUser.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOUser.h"

@implementation JOUser

@synthesize userId = _userId;
@synthesize userSecureToken = _userSecureToken;

- (id) initWithJSON:(NSData*) jsonData
{
    self = [super init];
    
    /* PARSE JSON DATA */
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:jsonData
                          options:kNilOptions 
                          error:&error];
    
    NSLog([json description]);
//    NSArray* idList = [json objectForKey:ID];
//    self.userId = [idList objectAtIndex:0];
    
    NSString* secureTokenList = [json valueForKey:SECURE_TOKEN];
    NSLog([secureTokenList description]);
    self.userSecureToken = secureTokenList;
    
    return self;
}

@end
