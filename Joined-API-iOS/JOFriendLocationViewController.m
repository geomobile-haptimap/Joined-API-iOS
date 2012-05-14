//
//  JOFriendLocationViewController.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOFriendLocationViewController.h"

#import "MapViewAnnotation.h"

@implementation JOFriendLocationViewController

@synthesize mapView = _mapView;
@synthesize friend = _friend;

- (id) initWithFriend:(JOFriend*) friend
{
    self = [super init];
    
    self.friend = friend;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:self.mapView];
    
	CLLocationCoordinate2D location;
	location.latitude = (double) self.friend.latitude.doubleValue;
	location.longitude = (double) self.friend.longitude.doubleValue;
    
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:self.friend.nickname andCoordinate:location];

    [self.mapView addAnnotation:newAnnotation];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([newAnnotation coordinate], 5000, 5000);
    [self.mapView setRegion:region animated:YES];
}

@end
