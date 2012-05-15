//
//  JoinedHTTPClient.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 01.12.11.
//  Copyright (c) 2011 GeoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface JOJoinedHTTPClient : AFHTTPClient

+ (JOJoinedHTTPClient*)sharedClient;

@end
