//
//  SMMessagesViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/26/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMMessagesViewController.h"

#import <Parse/Parse.h>

#import "SMProfileViewController.h"

#import "SMConstants.h"
#import "SMUtility.h"

@interface SMMessagesViewController ()

@property (nonatomic, strong) NSString *previousString;

@end

@implementation SMMessagesViewController

@synthesize previousString;

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
    self.navigationItem.title = @"SAFE MESSAGE";
    
    //SettingsButton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cog_deselected.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentSettingsView:)];
    
    [safeNumberField setDelegate:self];
    
    [self checkUsernameChanged];
    
}


//Find
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self checkUsernameChanged];
    return YES;
}


//checkUsername is changing
- (void)checkUsernameChanged{
    if([safeNumberField.text length] == [previousString length]){
        [self queryMessageObjects];
    }else{
        previousString = safeNumberField.text;
        [self performSelector:@selector(checkUsernameChanged) withObject:nil afterDelay:.3f];
    }
}

//Find User's Messages
- (void)queryMessageObjects{
    if([safeNumberField.text length] == 0){
        return;
    }
    
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:kSMUserUsernameKey equalTo:safeNumberField.text];
    [userQuery setCachePolicy:kPFCachePolicyCacheElseNetwork];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if(!error){
            if([users count] == 0){
                messages = nil;
                [self setMessageButtons];
            }else{
                for (PFUser *user in users) {
                    if([[user username] isEqualToString:safeNumberField.text]){
                        messages =  [user objectForKey:kSMUserFixedMessagesKey];
                        [self setMessageButtons];
                    }else{
                        [self queryMessageObjects];
                    }
                }
            }
        }
    }];
    
}

//
- (void)presentSettingsView:(id)sender{
    SMProfileViewController *profileViewController = [[SMProfileViewController alloc] init];
    [self.navigationController pushViewController:profileViewController animated:YES];
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
