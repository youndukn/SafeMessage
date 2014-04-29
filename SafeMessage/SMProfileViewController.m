//
//  SMProfileViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/12/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMProfileViewController.h"

#import <Parse/Parse.h>

#import "SMAppDelegate.h"

#import "SMAppDelegate.h"
#import "SMConstants.h"
#import "SMUtility.h"

@interface SMProfileViewController ()
@end

@implementation SMProfileViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set Navigation Items
    self.navigationItem.title = @"SETTING";
    
    //LoginButton
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    [safeNumberField setText:[[PFUser currentUser] username]];
    
}

- (void)setMyMessages{
    NSArray *myMessages = [[PFUser currentUser] objectForKey:kSMUserFixedMessagesKey];
    
}

- (void)logOut{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView.title isEqualToString:@"Logout?"]){
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
