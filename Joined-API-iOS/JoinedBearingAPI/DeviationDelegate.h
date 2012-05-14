//
//  DeviationDelegate.h
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 19.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol DeviationDelegate <NSObject>

- (void)setAzimuth:(CLLocationDirection)azimuth;

@end