//
//  CompassView.m
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 06.01.11.
//  Copyright 2011 GeoMobile GmbH. All rights reserved.
//

#import "CompassView.h"
#import "QuartzCore/QuartzCore.h"

@implementation CompassView
@synthesize rotationAnimated = _rotationAnimated, image = _image, azimuth = _azimuth;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		//Adding Subviews
		_compassImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		_compassImageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		_compassImageView.contentMode=UIViewContentModeScaleAspectFit;
		_compassImageView.image=[UIImage imageNamed:@"bearing.bundle/compassRose"];
		[self addSubview:_compassImageView];
		
		//Setting defaults
		_rotationAnimated=TRUE;
    }
    return self;
}

-(void)setImage:(UIImage *)image {
	_compassImageView.image=image;
}

-(UIImage *)image {
	return _compassImageView.image;
}

-(void)setAzimuth:(CLLocationDirection)azimuth {
	_azimuth=azimuth;
	
	if(_rotationAnimated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:2.0];
		_compassImageView.transform = CGAffineTransformMakeRotation(-_azimuth * M_PI / 180.f);
		[UIView commitAnimations];
	}
	else 
	{
		_compassImageView.transform = CGAffineTransformMakeRotation(-_azimuth * M_PI / 180.f);
	}
}

@end
