//
//  JOMessage.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 15.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOMessage.h"

@implementation JOMessage

@synthesize messageId = _messageId;
@synthesize senderId = _senderId;
@synthesize direction = _direction;
@synthesize content = _content;
@synthesize time = _time;

- (id) initWithJSON:(NSDictionary*) jsonData
{
    self = [super init];
    
    NSString* jsonMessageId = [jsonData objectForKey:ID];
    self.messageId = jsonMessageId;
    
    NSString* jsonSenderId = [jsonData objectForKey:SENDER_ID];
    self.senderId = jsonSenderId;

    NSNumber* jsonDirection = MESSAGE_FROM;
    self.direction = jsonDirection;

    NSString* jsonContent = [jsonData objectForKey:TEXT];
    self.content = jsonContent;

    NSNumber* jsonTime = [jsonData objectForKey:CREATION_DATE];
    self.time = jsonTime;
    
    return self;  
}

@end
