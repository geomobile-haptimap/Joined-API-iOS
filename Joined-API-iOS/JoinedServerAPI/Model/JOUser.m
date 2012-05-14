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

- (id) initWithJSON:(NSDictionary*) json
{
    self = [super init];

//    NSData* jsonData= [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSError* error;
//
//    NSDictionary* json = [NSJSONSerialization 
//                          JSONObjectWithData:jsonData
//                          options:kNilOptions 
//                          error:&error];
    
    NSNumber* jsonId = [json objectForKey:ID];
    self.userId = [jsonId stringValue];
    
    NSString* jsonSecureToken = [json valueForKey:SECURE_TOKEN];
    self.userSecureToken = jsonSecureToken;
    
    return self;
}

@end
