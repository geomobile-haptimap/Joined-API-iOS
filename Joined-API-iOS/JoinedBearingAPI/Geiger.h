//
//  Geiger.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BearingCore.h"
#include <AudioToolbox/AudioToolbox.h>

/**
 * The geiger gives accoustic feedback. When the deviation to the heading is small, the feedback repeats very frequently. With a rising deviation the frequency decreases.
 */
@interface Geiger : NSObject <BearingFeedbackDelegate> {
@private
	NSThread *_thread;
    CFURLRef _soundFileURLRef;
    SystemSoundID _soundFileObject;
	double _soundPause;
}

/**
 * Current deviation to the target in degrees. (0 = target is straight ahead, 90 = to the right, ...)
 */
@property (nonatomic, assign) CLLocationDirection deviation;

/**
 * Current status of the output. (TRUE = enabled, FALSE = disabled)
 */
@property (readonly, getter=isEnabled) BOOL enabled;

@end