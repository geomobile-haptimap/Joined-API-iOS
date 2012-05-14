//
//  JoinedHTTPClient.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 01.12.11.
//  Copyright (c) 2011 GeoMobile. All rights reserved.
//

#import "JoinedHTTPClient.h"

@implementation JoinedHTTPClient

+ (JoinedHTTPClient*)sharedClient
{
    static JoinedHTTPClient *instance = nil;
    if (!instance)
    {
        instance = [[JoinedHTTPClient alloc] init];
    }
    return instance;
}

@end
