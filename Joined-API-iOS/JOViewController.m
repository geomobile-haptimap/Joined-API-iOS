//
//  JOViewController.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOViewController.h"

#import "JOClient.h"
#import "JOFriendListViewController.h"

@interface JOViewController ()

@end

@implementation JOViewController
@synthesize usernameInputField;
@synthesize passwordInputField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUsernameInputField:nil];
    [self setPasswordInputField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated 
{
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)loginButtonPressed:(id)sender {
   
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];
    
    NSString* username = [self.usernameInputField text];
    NSString* password = [self.passwordInputField text];
    
    [client loginUser:username andPassword:password success:^(JOUser *user) 
     {
         NSLog(@"Hello World");
         
         JOFriendListViewController* friendView = [[JOFriendListViewController alloc] initWithUser:user];
         [self.navigationController pushViewController:friendView animated:YES];
         
     } failed:^(NSError *error) 
     {
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         
         [alert show];
         
     } ];
}

@end
