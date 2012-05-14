//
//  JOFriendListViewController.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JOUser.h"

@interface JOFriendListViewController : UITableViewController

@property (atomic, strong) NSArray* friendList;

- (id) initWithUser:(JOUser*) user;

@end
