//
//  JOClient.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JOUser.h"

typedef void (^WebServiceFailedBlock)(NSError *error);

typedef void (^UserWebServiceSuccessBlock)(JOUser *user);

@interface JOClient : NSObject

@property (atomic, strong) NSString* joinedServerUrl;
@property (atomic, strong) NSString* joinedApiKey;

- (id) initServer:(NSString*)joinedServerUrl andApiKey:(NSString*)joinedApiKey;

- (void) loginUser:(NSString*)username andPassword:(NSString*)password success:(UserWebServiceSuccessBlock)successBlock failed:(WebServiceFailedBlock)failedBlock;

@end
