//
//  NavigationViewController.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 30.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BearingCore.h"
#import <CoreLocation/CoreLocation.h>

@class CompassView;

@interface DestinationViewController : UIViewController <AzimuthStatusDelegate, LocationStatusDelegate> {
    
@protected
    NSString *_destinationTitle;
	UILabel *_distanceLabel;
	CompassView *_compassView;
	BearingCore *_bearingCore;
	BOOL _closeToDestination;	
}

/**
 * This function initializes the ViewController with a given Title (used for the map-icon) and a target location.
 * 
 * \param title Title of the target
 * \return coordinate Target location
 */
- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate;

@end