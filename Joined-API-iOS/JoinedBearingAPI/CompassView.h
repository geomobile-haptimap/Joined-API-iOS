//
//  CompassView.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviationDelegate.h"

/**
 * ComassView displays a compass rose pointing to the specified azimuth (e.g. target location)
 */
@interface CompassView : UIView <DeviationDelegate> {
@private
	UIImageView *_compassImageView;
}

/**
 * Image of the compass rose
 */
@property (nonatomic, retain) UIImage *image;

/**
 * Current azimuth to display.
 */
@property (nonatomic, assign) CLLocationDirection azimuth;

/**
 * Boolean determining the animation status. (TRUE = Rotation is animated, FALSE = Rotation is not animated)
 */
@property (nonatomic, assign, getter=isRotationAnimated) BOOL rotationAnimated;

@end
