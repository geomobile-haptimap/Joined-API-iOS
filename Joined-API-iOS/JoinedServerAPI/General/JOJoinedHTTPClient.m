//
//  JoinedHTTPClient.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 01.12.11.
//  Copyright (c) 2011 GeoMobile. All rights reserved.
//

#import "JOJoinedHTTPClient.h"

@implementation JOJoinedHTTPClient

+ (JOJoinedHTTPClient*)sharedClient
{
    static JOJoinedHTTPClient *instance = nil;
    if (!instance)
    {
        instance = [[JOJoinedHTTPClient alloc] init];
    }
    return instance;
}

@end
