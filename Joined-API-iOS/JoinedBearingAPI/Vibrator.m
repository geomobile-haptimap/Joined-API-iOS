//
//  Vibrator.m
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import "Vibrator.h"

@implementation Vibrator
@synthesize enabled = _enabled, deviation = _deviation;

- (id)init {
    if ((self = [super init])) {	
		_soundPause=MAXFLOAT;
		
		//Start with invalid deviation
		_deviation=-1;
    }
    return self;
}

-(void)dealloc {
	[self stop];
}

//In the Simulator and on devices with no vibration element, this method does nothing.
- (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark -
#pragma mark GeigerThread

// This method is invoked from the driver thread
- (void)threadRun:(id)info {
    
    // Give the sound thread high priority to keep the timing steady.
    [NSThread setThreadPriority:1.0];
    BOOL continuePlaying = YES;
    
    while (continuePlaying) {   // Loop until cancelled.	
		
        // An autorelease pool to prevent the build-up of temporary objects.
        @autoreleasepool {
            
            NSDate *currentTime = [NSDate date];
            
            [self vibrate];		
            
            if ([_thread isCancelled] == YES) {
                continuePlaying = NO;
            }
            [NSThread sleepForTimeInterval:0.001];
            
            // Wake up periodically to see if we've been cancelled.
            while (continuePlaying && (-[currentTime timeIntervalSinceNow] < _soundPause)) { 
                if ([_thread isCancelled] == YES) {
                    continuePlaying = NO;
                }
                [NSThread sleepForTimeInterval:0.01];
            }	
        }
    }
}

- (void)waitForThreadToFinish {
    while (_thread && ![_thread isFinished]) { // Wait for the thread to finish.
        [NSThread sleepForTimeInterval:0.1];
    }
}

#pragma mark -
#pragma mark ToolkitOutputDelegate Methods

- (void)start {
    [self stop];
    
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun:) object:nil];
    [_thread start];
}

- (void)stop {    
	if (_thread) {
		[_thread cancel];
		[self waitForThreadToFinish];
		_thread = nil;
	}
}

#pragma mark -
#pragma mark getter/setter

-(BOOL)isEnabled {
	return [_thread isExecuting];
}

-(void)setDeviation:(CLLocationDirection)deviation {
	_deviation=deviation;
	//Audio-Feedback occurrence depends on deviation
	if(_deviation<0)
	{
		//Invalid
		_soundPause=MAXFLOAT;		
	}
	else if (_deviation<=90 || _deviation>=270) 
	{
		_soundPause=1.7+cos(_deviation*M_PI/180+M_PI)*1.3;
	}
	else {
		//No Sound for wrong direction
		_soundPause=MAXFLOAT;
	}
}

@end
