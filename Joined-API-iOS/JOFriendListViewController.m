//
//  JOFriendListViewController.m
//  Joined-API-iOS
//
//  Created by Bastian Baranski on 5/14/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JOFriendListViewController.h"

#import "JOClient.h"
#import "JOFriend.h"
#import "JOFriendLocationViewController.h"
#import "DestinationViewController.h"

@implementation JOFriendListViewController

@synthesize friendList = _friendList;

- (id) initWithUser:(JOUser*) user;
{
    self = [super init];
    
    JOClient* client = [[JOClient alloc] initServer:JOINED_SERVER andApiKey:JOINED_API_KEY];

    [client getFriendsForUser:user success:^(NSArray *friends) 
    {
        self.friendList = friends;
        [self.tableView reloadData];
        
    } failed:^(NSError *error) 
    {
        NSLog(error);
    } ]; 
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTableCell"];
       
    JOFriend* friend = [self.friendList objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.nickname;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JOFriend* friend = [self.friendList objectAtIndex:indexPath.row];
    
    JOFriendLocationViewController* friendLocationView = [[JOFriendLocationViewController alloc] initWithFriend:friend];
    [self.navigationController pushViewController:friendLocationView animated:YES]; 
}

@end
