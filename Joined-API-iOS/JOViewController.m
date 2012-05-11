//
//  JOViewController.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOViewController.h"

#import "JOClient.h"

@interface JOViewController ()

@end

@implementation JOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    [client loginUser:@"b.baranski" andPassword:@"b.baranski" success:^(JOUser *user) 
    {
        NSLog(@"Hello World");
    } failed:^(NSError *error) 
    {
        NSLog(@"Ciao World");
    } ];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
