//
//  GMToolkitAPI.m
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import "BearingCore.h"
#import "Geiger.h"
#import "Vibrator.h"

@interface BearingCore (private)

/**
 * Private method that is internally used to calculate the heading between two locations.
 * 
 * \param _location1 First location.
 * \param _location2 Second location.
 * \return Heading between location1 and location2 in degrees. (0 = straight ahead, 90 = to the right, ...)
 */
- (double)headingFromLocation:(CLLocation *)_location1 toLocation:(CLLocation *)_location2;

@end

@implementation BearingCore
@synthesize locationManager=_locationManager,
compassViewDelegate=_compassViewDelegate, 
locationStatusDelegate = _locationStatusDelegate,
azimuthStatusDelegate = _azimuthStatusDelegate,
targetLocation = _targetLocation,
bearingFeedback = _bearingFeedback;

- (id)init {
    if ((self = [super init])) {	
        
		//Setting Outputs
		_geiger = [[Geiger alloc] init];
		_vibrator = [[Vibrator alloc] init];
		
		//Setting Defaults
		_currentDeviation=-1;
		_compassViewDelegate=nil;
		_locationStatusDelegate=nil;
		_azimuthStatusDelegate=nil;
        _bearingFeedback=BearingFeedbackNone;
    }
    return self;
}

- (void)dealloc {
	[self stop];
}

-(void)start {
	if(!_locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		_locationManager.distanceFilter = 10;
		_locationManager.headingOrientation=CLDeviceOrientationUnknown;
	}
	
	[_locationManager startUpdatingLocation];
	[_locationManager startUpdatingHeading];	
}

- (void)stop {
    self.bearingFeedback=BearingFeedbackNone;
	if(_locationManager) {
		[_locationManager stopUpdatingLocation];
		[_locationManager stopUpdatingHeading];	
	}
}

/*Formula:
 
 //Orthodrome <- used
 var y = Math.sin(dLon) * Math.cos(lat2);
 var x = Math.cos(lat1)*Math.sin(lat2) -
 Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLon);
 var brng = Math.atan2(y, x).toDeg();
 
 //Loxodrome
 var dPhi = Math.log(Math.tan(lat2/2+Math.PI/4)/Math.tan(lat1/2+Math.PI/4));
 var q = (!isNaN(dLat/dPhi)) ? dLat/dPhi : Math.cos(lat1);  // E-W line gives dPhi=0
 
 // if dLon over 180° take shorter rhumb across 180° meridian:
 if (Math.abs(dLon) > Math.PI) {
 dLon = dLon>0 ? -(2*Math.PI-dLon) : (2*Math.PI+dLon);
 }
 var d = Math.sqrt(dLat*dLat + q*q*dLon*dLon) * R;
 var brng = Math.atan2(dLon, dPhi);
 */
- (double)headingFromLocation:(CLLocation *)_location1 toLocation:(CLLocation *)_location2
{
	double dLon = (_location2.coordinate.longitude-_location1.coordinate.longitude)*M_PI/180;
	double lat1 = _location1.coordinate.latitude*M_PI/180;
	double lat2 = _location2.coordinate.latitude*M_PI/180;
	double y = sin(dLon)*cos(lat2);
	double x = cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(dLon);
	double brng = atan2(y, x);
	if (brng < 0)
        brng += 2*M_PI;
	return brng*180.f/M_PI;
}

- (void)setBearingFeedback:(BearingFeedback)bearingFeedback {
    BearingFeedback feedbackToCheck;
    
    //Geiger
    feedbackToCheck=BearingFeedbackGeiger;
    if ((_bearingFeedback & feedbackToCheck) && !(bearingFeedback & feedbackToCheck)) {
        //switch off
		[_geiger stop];
    }
    else if (!(_bearingFeedback & feedbackToCheck) && (bearingFeedback & feedbackToCheck)){
        //switch on
		[_geiger setDeviation:_currentDeviation];
		[_geiger start];
    }
    
    //Vibrator
    feedbackToCheck=BearingFeedbackVibration;
    if ((_bearingFeedback & feedbackToCheck) && !(bearingFeedback & feedbackToCheck)) {
        //switch off
		[_vibrator stop];
    }
    else if (!(_bearingFeedback & feedbackToCheck) && (bearingFeedback & feedbackToCheck)){
        //switch on
		[_vibrator setDeviation:_currentDeviation];
		[_vibrator start];
    }
    _bearingFeedback = bearingFeedback;
}

#pragma mark -
#pragma mark locationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {	
	//Check if location is valid
	if (newLocation.horizontalAccuracy < 0) { return;}
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0){return;}
	
	if(newLocation.horizontalAccuracy>999){return;}
	
	//Save new Location
	_currentLocation = newLocation;
	
	if(_targetLocation)
	{
		_desiredHeading=[self headingFromLocation:_currentLocation toLocation:_targetLocation];
		_distanceToTarget=[newLocation distanceFromLocation:_targetLocation];
		if(_locationStatusDelegate)
		{
			[_locationStatusDelegate locationChangedToCurrentLocation:newLocation andTargetLocation:_targetLocation andTargetAzimuth:_desiredHeading andDistance:_distanceToTarget];
		}
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self stop];
	NSLog(@"locationManager:didFailWithError:%@",[error description]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	double heading = newHeading.magneticHeading;
	
	if(abs(heading-_currentHeading)>0 && _currentLocation && _targetLocation) {
		_currentHeading=heading;
		//double deviation = fmod(desiredHeading-heading,360);
		//if(deviation>180)deviation-=360;
		//TODO: [lblHeading setText:[NSString stringWithFormat:@"CurrentPosition:%f,%f\nTarget Position:%f,%f\nCurrent Heading: %.1f\nTarget Heading: %.1f\nDeviation: %.1f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,targetLocation.coordinate.latitude,targetLocation.coordinate.longitude,heading,desiredHeading,deviation]];
		double deviation=heading-_desiredHeading;
		if (deviation<0) {
			deviation+=360;
		}
		
		_currentDeviation=deviation;
		
		if (_bearingFeedback & BearingFeedbackGeiger)
			[_geiger setDeviation:deviation];
		
		if (_bearingFeedback & BearingFeedbackVibration)
			[_vibrator setDeviation:deviation];
		
		if (_azimuthStatusDelegate)
			[_azimuthStatusDelegate azimuthChangedToCurrentAzimuth:heading andDeviation:_currentDeviation];
	}
}


#pragma mark -
#pragma mark getter/setter

- (void)setLocationManager:(CLLocationManager *)locationManager {
    [self stop];
    _locationManager = locationManager;
}

@end
