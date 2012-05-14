//
//  Vibrator.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BearingCore.h"
#include <AudioToolbox/AudioToolbox.h>

/**
 * The vibrator gives tactile feedback using a defined pattern:
 * Target is ...
 * straight ahead: one vibration repeated every 2 seconds
 * to the right: two vibrations seperated by a 500ms break and repeated every 2 seconds
 * to the left: three vibrations seperated by a 500ms break and repeated every 2 seconds
 * behind: four vibrations seperated by a 500ms break and repeated every 2 seconds
 */
@interface Vibrator : NSObject <BearingFeedbackDelegate> {	
@private
    NSThread *_thread;
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
