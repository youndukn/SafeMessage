//
//  SMMainViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMMainViewController.h"

#import <Parse/Parse.h>

#import "SMProfileViewController.h"

#import "SMAppDelegate.h"

#import "SMAppDelegate.h"
#import "SMConstants.h"
#import "SMUtility.h"

@interface SMMainViewController ()

@property (nonatomic, strong) UITextField *safeNumberField;

@property (nonatomic, strong) UIScrollView *messageHolderView;

@property (nonatomic, strong) NSArray *myMessages;
@property (nonatomic, assign) BOOL usernameCheckInProgress;
@property (nonatomic, strong) NSString *previousString;

@end

@implementation SMMainViewController

@synthesize safeNumberField;

@synthesize messageHolderView;

@synthesize myMessages;
@synthesize usernameCheckInProgress;
@synthesize previousString;


const float sideInset = 10.0f;
const float topInset = 40.0f;
const float fieldHeight = 60.0f;
const float buttonHeight = 40.0f;

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
    
    if(![PFUser currentUser]){
        [(SMAppDelegate *)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    //Set Navigation Items
    self.navigationItem.title = @"안전문자";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //SafeNumberField
    safeNumberField = [[UITextField alloc] initWithFrame:CGRectMake(sideInset, topInset*2, screenRect.size.width-sideInset*2, fieldHeight)];
    
    [safeNumberField setPlaceholder:@"안전번호"];
    [safeNumberField setTextAlignment:NSTextAlignmentCenter];
    [safeNumberField setFont:[UIFont systemFontOfSize:30]];
    [safeNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [safeNumberField setKeyboardType:UIKeyboardTypeNumberPad];
    if([[NSUserDefaults standardUserDefaults] objectForKey:kSMNSUserDefaultPreviousUserKey]){
        [safeNumberField setText:[[NSUserDefaults standardUserDefaults] objectForKey:kSMNSUserDefaultPreviousUserKey]];
    }
    [safeNumberField setDelegate:self];
    
    [self.view addSubview:safeNumberField];
    
    //LoginButton
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settingsButton setImage:[UIImage imageNamed:@"icon_cog_deselected.png"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(presentSettingsView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(sideInset, topInset*2+fieldHeight+topInset/2, screenRect.size.width-sideInset*2, buttonHeight)];
    
    [submitButton setTitle:@"메세지 찾기" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [submitButton setBackgroundColor:[SMUtility submitColor]];
    [submitButton addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    //Message Holder Set
    [self setMessageButtonsInHolderView];
    
    usernameCheckInProgress = NO;
    
}

- (void)presentSettingsView:(id)sender{
    SMProfileViewController *profileViewController = [[SMProfileViewController alloc] init];
    [self.navigationController presentViewController:profileViewController animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(!usernameCheckInProgress){
        usernameCheckInProgress = YES;
        [self performSelector:@selector(checkUsername) withObject:nil afterDelay:.5f];
    }
    return YES;
}

- (void)checkUsername{
    usernameCheckInProgress = NO;
    if(safeNumberField.text == previousString){
        [self queryMessageObjects];
    }else{
        usernameCheckInProgress = YES;
        [self performSelector:@selector(checkUsername) withObject:nil afterDelay:.5f];
    }
}

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
                myMessages = nil;
                [self setMessageButtonsInHolderView];
            }else{
                for (PFUser *user in users) {
                    myMessages =  [user objectForKey:kSMUserFixedMessagesKey];
                    [self setMessageButtonsInHolderView];
                }
            }
        }
    }];
}

- (void)setMessageButtonsInHolderView{
    
    //Submit Button
    if(!self.messageHolderView){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        messageHolderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topInset*2+fieldHeight, screenRect.size.width, screenRect.size.height-topInset*2+fieldHeight)];
        [self.view addSubview:messageHolderView];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    int sideRL = sideInset;
    int middleRL = 8;
    int sideTB = 10;
    int middleTB = 5;
    
    
    messageHolderView.contentSize = CGSizeMake(screenRect.size.width, 40.0f*[myMessages count]+10*2 + middleTB*[myMessages count]);
    
    for(UIView *view in [self.messageHolderView subviews]){
        [view removeFromSuperview];
    }
    
    if(!myMessages){
        myMessages = [NSArray arrayWithObjects:@"찾지 못하였습니다", nil];
        return;
    }
    
    NSArray *messagesRect = [SMUtility getFramesWithColumns:1 Row:(int)([myMessages count]) Width:messageHolderView.contentSize.width Height:messageHolderView.contentSize.height SideRL:sideRL MiddleRL:middleRL SideTB:sideTB MiddleTB:middleTB];
    
    for(int i = 0; i < [myMessages count]; i++){
        UIButton *submitButton = [[UIButton alloc] initWithFrame:[[messagesRect objectAtIndex:i] CGRectValue]];
        
        [submitButton setTitle:@"자동차 빼주세요" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [submitButton setBackgroundColor:[SMUtility submitColor]];
        [submitButton addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
        [submitButton setTag:i];
        
        [self.messageHolderView addSubview:submitButton];
    }
    
   
}

- (void)setState:(id)sender{
    if([sender isOn]){
        
    }else{
        [(SMAppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
    }
}

- (void)submitMessage:(id)sender{
    if([safeNumberField.text length] > 0){
        [[NSUserDefaults standardUserDefaults] setObject:safeNumberField.text forKey:kSMNSUserDefaultPreviousUserKey];
        
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
