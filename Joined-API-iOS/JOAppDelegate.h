//
//  JOAppDelegate.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JOViewController;

@interface JOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JOViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
