//
//  NavigationViewController.m
//  TactileCompassTest
//
//  Created by Christopher Goldschmidt on 30.11.10.
//  Copyright 2010 GeoMobile. All rights reserved.
//

#import "DestinationViewController.h"
#import "CompassView.h"


@implementation DestinationViewController

- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {	
        _destinationTitle = [title copy];
		_bearingCore = [[BearingCore alloc] init];
		CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
		_bearingCore.targetLocation=targetLocation;
    }
    return self;
}

- (void)dealloc {
	[_bearingCore stop];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024-20-44)];
        view.backgroundColor = [UIColor blackColor];
        self.view =view;
        
        UIView *backgroundImageView = [[UIView alloc] initWithFrame:self.view.bounds];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundImageView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [self.view addSubview:backgroundImageView];
        
        UILabel *label;
        CGRect rect=CGRectMake(100, 10, 568, 90);
        label = [[UILabel alloc] initWithFrame:rect];
        label.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        label.textColor=[UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment=UITextAlignmentCenter;
        label.numberOfLines=2;
        label.font=[UIFont systemFontOfSize:26.];
        label.text=NSLocalizedString(@"Warte auf GPS", @"");
        [self.view addSubview:label];
        _distanceLabel=label;
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: NSLocalizedString(@"Vibration", @""), NSLocalizedString(@"Geiger", @""), nil]];
        segmentedControl.frame = CGRectMake(100, 1024-20-44-50-100, 568, 50);
        segmentedControl.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        segmentedControl.segmentedControlStyle=UISegmentedControlStyleBezeled;
        segmentedControl.tintColor=[UIColor darkGrayColor];
        segmentedControl.selectedSegmentIndex=0;
        [segmentedControl addTarget:self action:@selector(outputModeSegmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        
        rect = CGRectMake(100, CGRectGetMaxY(rect)+150, 568, CGRectGetMinY(segmentedControl.frame)-CGRectGetMinY(rect)-300);
        
        _compassView=[[CompassView alloc] initWithFrame:rect];
        _compassView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _compassView.image = [UIImage imageNamed:@"compassRose568"];
        [self.view addSubview:_compassView];
    }
    else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-20-44)];
        view.backgroundColor = [UIColor blackColor];
        self.view =view;
        
        UIView *backgroundImageView = [[UIView alloc] initWithFrame:self.view.bounds];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundImageView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [self.view addSubview:backgroundImageView];
        
        UILabel *label;
        CGRect rect=CGRectMake(10, 10, 300, 90);
        label = [[UILabel alloc] initWithFrame:rect];
        label.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        label.textColor=[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment=UITextAlignmentCenter;
        label.numberOfLines=2;
        label.font=[UIFont systemFontOfSize:26.];
        label.text=NSLocalizedString(@"Warte auf GPS", @"");
        [self.view addSubview:label];
        _distanceLabel=label;
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: NSLocalizedString(@"Vibration", @""), NSLocalizedString(@"Geiger", @""), nil]];
        segmentedControl.frame = CGRectMake(10, 340, 300, 50);
        segmentedControl.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        segmentedControl.segmentedControlStyle=UISegmentedControlStyleBezeled;
        segmentedControl.tintColor=[UIColor darkGrayColor];
        segmentedControl.selectedSegmentIndex=0;
        [segmentedControl addTarget:self action:@selector(outputModeSegmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        
        rect.origin.y=CGRectGetMaxY(rect)+10;
        rect.size.height=CGRectGetMinY(segmentedControl.frame)-CGRectGetMinY(rect)-10;
        
        _compassView=[[CompassView alloc] initWithFrame:rect];
        _compassView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_compassView];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	self.title=NSLocalizedString(@"", @"");
	
	_bearingCore.locationStatusDelegate=self;
	_bearingCore.azimuthStatusDelegate=self;
    
    [_bearingCore setBearingFeedback:BearingFeedbackVibration];
    
	[_bearingCore start];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Schließen", @"") style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonPressed)];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    _bearingCore.locationStatusDelegate = nil;
    _bearingCore.azimuthStatusDelegate = nil;
    
    _distanceLabel = nil;
    
    _compassView = nil;
}

-(void)outputModeSegmentedControlChanged:(UISegmentedControl *)segmentedControl {
    if(segmentedControl.selectedSegmentIndex==0) {
		//Vibration
        _bearingCore.bearingFeedback = BearingFeedbackVibration;
	}
    else if(segmentedControl.selectedSegmentIndex==1) {
		//Geiger
        [_bearingCore setBearingFeedback:BearingFeedbackGeiger];
	}
}

#pragma mark -
#pragma mark ToolkitLocationStatusDelegate

-(void)locationChangedToCurrentLocation:(CLLocation *)currentLocation andTargetLocation:(CLLocation *)targetLocation andTargetAzimuth:(CLLocationDirection)targetAzimuth andDistance:(CLLocationDistance)distance {
	if(distance<1000)	{
		_distanceLabel.text=[NSString stringWithFormat:NSLocalizedString(@"Entfernung: %.0f m\nGenauigkeit: %.0f m", @""),distance, currentLocation.horizontalAccuracy];
        _distanceLabel.accessibilityLabel = [NSString stringWithFormat:NSLocalizedString(@"Entfernung: %.0f Meter\nGenauigkeit: %.0f Meter", @""),distance, currentLocation.horizontalAccuracy];
	}
	else{
		_distanceLabel.text=[NSString stringWithFormat:NSLocalizedString(@"Entfernung: %.1f km\nGenauigkeit: %.0f m", @""),distance/1000, currentLocation.horizontalAccuracy];
        _distanceLabel.accessibilityLabel = [NSString stringWithFormat:NSLocalizedString(@"Entfernung: %.1f Kilometer\nGenauigkeit: %.0f Meter", @""),distance/1000, currentLocation.horizontalAccuracy];
	}
	if(distance<15 && !_closeToDestination)	{
		_closeToDestination=TRUE;
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Achtung", @"") message:NSLocalizedString(@"Zielort erreicht.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil];
		[alert show];
	}
}

#pragma mark -
#pragma mark ToolkitAzimuthStatusDelegate

-(void)azimuthChangedToCurrentAzimuth:(CLLocationDirection)currentAzimuth andDeviation:(CLLocationDirection)deviation {
	[_compassView setAzimuth:deviation];
}

- (void)cancelButtonPressed {
	[_bearingCore stop];
	[self.navigationController popViewControllerAnimated:YES];
}

@end
