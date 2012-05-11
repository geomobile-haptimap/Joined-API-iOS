//
//  NSString+easyHash.h
//  FriendFinder
//
//  Created by Nils Lattek on 14.04.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(easyHash) 

- (NSString *)sha1;
- (NSString *)md5;

@end
