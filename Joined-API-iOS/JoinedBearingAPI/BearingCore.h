//
//  GMToolkitAPI.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Geiger, Vibrator;
@protocol DeviationDelegate;
@protocol LocationStatusDelegate;
@protocol AzimuthStatusDelegate;

enum {
    BearingFeedbackNone                 = 0,
    BearingFeedbackVibration            = 1 << 0,
    BearingFeedbackGeiger               = 1 << 1
};
typedef NSUInteger BearingFeedback;

@interface BearingCore : NSObject <CLLocationManagerDelegate> {
@private
	CLLocation *_currentLocation;
	double _currentHeading;
	double _desiredHeading;
	double _currentDeviation;
	double _distanceToTarget;
	
	//Output
	Geiger *_geiger;
	Vibrator *_vibrator;
}

/**
 * The locationManager used by the toolkit. Default: automatically created. Can be modified or changed as desired.
 */
@property (nonatomic, retain) CLLocationManager *locationManager;

/**
 * The locationManager used by the toolkit. Default: automatically created. Can be modified or changed as desired.
 */
@property (nonatomic, assign) id <DeviationDelegate> compassViewDelegate;

/**
 * Delegate that supports the ToolkitLocationStatusDelegate. Gets informed about location changes.
 */
@property (nonatomic, assign) id <LocationStatusDelegate> locationStatusDelegate;

/**
 * Delegate that supports the ToolkitAzimuthStatusDelegate. Gets informed about azimuth changes.
 */
@property (nonatomic, assign) id <AzimuthStatusDelegate> azimuthStatusDelegate;

/**
 * Location of the target.
 */
@property (nonatomic, retain) CLLocation *targetLocation;

/**
 * Sets the active outputs. Available: BearingFeedbackNone, BearingFeedbackVibration, BearingFeedbackGeiger.
 */
@property (nonatomic, assign) BearingFeedback bearingFeedback;

/**
 * This function starts the actual work of the toolkit. The locationmanager 
 * gets enabled and the heading gets determined. As soon as the location is aquired, 
 * delegates get notified.
 */
-(void)start;

/**
 * This function stops the toolkit.
 */
-(void)stop;

@end

/*
 Protocol for the ToolkitOutput's delegate.
 */
@protocol BearingFeedbackDelegate <NSObject>

/**
 * This function starts the output. 
 */
-(void)start;

/**
 * This function stops the output. 
 */
-(void)stop;

/**
 * This function is called when the deviation to the target-location has changed.
 * 
 * \param deviation Deviation to the target-location in degrees. (0 = target is straight ahead, 90 = to the right, ...)
 */
-(void)setDeviation:(CLLocationDirection)deviation;

@end

/*
 Protocol for the ToolkitLocationStatusDelegate.
 */
@protocol LocationStatusDelegate <NSObject>

/**
 * This function is called when the current location has changed.
 * 
 * \param currentLocation Current GPS location.
 * \param targetLocation Target GPS location.
 * \param targetAzimuth Azimuth to the target towards north in degrees. (0 = target is in northern direction, 90 = target is in eastern direction, ...)
 * \param distance Distance to the target in metres.
 */
-(void)locationChangedToCurrentLocation:(CLLocation *)currentLocation andTargetLocation:(CLLocation *)targetLocation andTargetAzimuth:(CLLocationDirection)targetAzimuth andDistance:(CLLocationDistance)distance;

@end

/*
 Protocol for the ToolkitAzimuthStatusDelegate.
 */
@protocol AzimuthStatusDelegate <NSObject>

/**
 * This function is called when the deviation to the target-location has changed.
 * 
 * \param currentAzimuth Current azimuth toward north (0 = currently facing north, 90 = facing east, ...).
 * \param deviation Deviation to the target-location in degrees. (0 = target is straight ahead, 90 = to the right, ...)
 */
-(void)azimuthChangedToCurrentAzimuth:(CLLocationDirection)currentAzimuth andDeviation:(CLLocationDirection)deviation;

@end
