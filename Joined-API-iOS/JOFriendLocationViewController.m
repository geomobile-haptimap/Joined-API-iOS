//
//  JOFriendLocationViewController.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOFriendLocationViewController.h"

#import "MapViewAnnotation.h"
#import "DestinationViewController.h"

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
    self.mapView.delegate = self;
    
	CLLocationCoordinate2D location;
	location.latitude = (double) self.friend.latitude.doubleValue;
	location.longitude = (double) self.friend.longitude.doubleValue;
    
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:self.friend.nickname andCoordinate:location];

    [self.mapView addAnnotation:newAnnotation];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([newAnnotation coordinate], 5000, 5000);
    [self.mapView setRegion:region animated:YES];
    
    [self.view addSubview:self.mapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)myMapView viewForAnnotation:(id <MKAnnotation>)annotation
{    
    static NSString *identifier = @"StationAnnotationIdentifier"; 
    
    if ([annotation isKindOfClass:[MapViewAnnotation class]])
    {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) 
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = calloutButton;
        annotationView.pinColor = MKPinAnnotationColorRed;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    CLLocationCoordinate2D location;
	location.latitude = (double) self.friend.latitude.doubleValue;
	location.longitude = (double) self.friend.longitude.doubleValue;

    DestinationViewController* destinationViewController = [[DestinationViewController alloc] initWithTitle:@"Bearing" andCoordinate:location];
    
    [self.navigationController pushViewController:destinationViewController animated:YES];   
}


@end
