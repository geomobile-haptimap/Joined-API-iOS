//
//  JOFriendLocationViewController.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "JOFriend.h"

@interface JOFriendLocationViewController : UIViewController<MKMapViewDelegate>

@property (strong, atomic) MKMapView* mapView;
@property (strong, atomic) JOFriend* friend;

- (id) initWithFriend:(JOFriend*) friend;

@end
