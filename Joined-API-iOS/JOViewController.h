//
//  JOViewController.h
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 07.05.12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JOViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameInputField;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;

- (IBAction)loginButtonPressed:(id)sender;

@end
